# aksdev@upn.com
# akssre@upn.com

# Create an Azure AD group
az ad group create --display-name myAKSAdminGroup --mail-nickname myAKSAdminGroup
AKS_ID=$(az aks show --resource-group rg-akvpoc-aksakv --name akvpoc-aks1 --query id -o tsv)

# Create the AKS DEV Group
APPDEV_ID=$(az ad group create --display-name appdev --mail-nickname appdev --query id -o tsv)
az role assignment create --assignee $APPDEV_ID --role "Azure Kubernetes Service Cluster User Role" --scope $AKS_ID
# Create a user for the AKS DEV role and add to the DEV group
echo "Please enter the UPN for application developers - user@domain.com: " && read AAD_DEV_UPN
echo "Please enter the secure password for users: " && read AAD_DEV_PW
AKSDEV_ID=$(az ad user create --display-name "AKS Dev" --user-principal-name $AAD_DEV_UPN --password $AAD_DEV_PW --query id -o tsv)
az ad group member add --group appdev --member-id $AKSDEV_ID

# Create the OPS SRE Group
OPSSRE_ID=$(az ad group create --display-name opssre --mail-nickname opssre --query id -o tsv)
az role assignment create --assignee $OPSSRE_ID --role "Azure Kubernetes Service Cluster User Role" --scope $AKS_ID
# Create a user for the SRE role and add to the SRE group
echo "Please enter the UPN for application developers - user@domain.com: " && read AAD_SRE_UPN
AKSSRE_ID=$(az ad user create --display-name "AKS SRE" --user-principal-name $AAD_SRE_UPN --password $AAD_DEV_PW --query id -o tsv)
az ad group member add --group opssre --member-id $AKSSRE_ID

# Notice that we are using --admin, the admin user bypasses Azure AD sign in prompts
az aks get-credentials --resource-group rg-akvpoc-aksakv --name akvpoc-aks1 --admin

# Create dev namespace
kubectl create namespace dev
# Create full access dev user role
cat << EOF > role-dev-namespace.yaml
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: dev-user-full-access
  namespace: dev
rules:
- apiGroups: ["", "extensions", "apps"]
  resources: ["*"]
  verbs: ["*"]
- apiGroups: ["batch"]
  resources:
  - jobs
  - cronjobs
  verbs: ["*"]
EOF

kubectl apply -f role-dev-namespace.yaml

APPDEV_GROUP_ID=$(az ad group show --group appdev --query objectId -o tsv)
# Create standard dev user role
cat << EOF > rolebinding-dev-namespace.yaml
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: dev-user-access
  namespace: dev
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: dev-user-full-access
subjects:
- kind: Group
  namespace: dev
  name: ${APPDEV_GROUP_ID}
EOF

cat rolebinding-dev-namespace.yaml | envsubst | kubectl apply -f - # rolebinding-dev-namespace.yaml

# Create SRE Namespace
kubectl create namespace sre

cat << EOF > role-sre-namespace.yaml
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: sre-user-full-access
  namespace: sre
rules:
- apiGroups: ["", "extensions", "apps"]
  resources: ["services", "endpoints", "pods"]
  #resources: ["*"]
  verbs: ["*"]
- apiGroups: ["batch"]
  resources:
  - jobs
  - cronjobs
  verbs: ["*"]
EOF
kubectl apply -f role-sre-namespace.yaml

cat << EOF > rolebinding-sre-namespace.yaml
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: sre-user-access
  namespace: sre
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: sre-user-full-access
subjects:
- kind: Group
  namespace: sre
  name: ${OPSSRE_GROUP_ID}
EOF

OPSSRE_GROUP_ID=$(az ad group show --group opssre --query objectId -o tsv)

cat rolebinding-sre-namespace.yaml | envsubst | kubectl apply -f - # rolebinding-dev-namespace.yaml

# Reset the kubeconfig to not use --admin
# this causes a user context to be applied that requires all requests to be authenticated using Azure AD
# Notice that we are using --admin, the admin user bypasses Azure AD sign in prompts
az aks get-credentials --resource-group rg-akvpoc-aksakv --name akvpoc-aks1 --overwrite-existing

# Let's schedule a basic nginx pod
kubectl run nginx-dev --image=mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine --namespace dev

# nginx pod should be running
kubectl get pods --namespace dev

# Access should be forbidden
kubectl get pods --all-namespaces

# Attempt to create pod in SRE namespace - access should be forbidden
kubectl run nginx-dev --image=mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine --namespace sre

# Overwrite existing kubeconfig to clear the previously cached authentication token
az aks get-credentials --resource-group rg-akvpoc-aksakv --name akvpoc-aks1 --overwrite-existing
kubectl run nginx-sre --image=mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine --namespace sre
kubectl get pods --namespace sre

# Access should be forbidden
kubectl get pods --all-namespaces
# Attempt to create pod in DEV namespace - access should be forbidden
kubectl run nginx-sre --image=mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine --namespace dev