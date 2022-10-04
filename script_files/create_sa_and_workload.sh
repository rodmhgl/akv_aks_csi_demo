# Must be run **after** set_env_var.sh as it will consume those vars
# Commands taken from
kubectl annotate sa ${SERVICE_ACCOUNT_NAME} -n ${SERVICE_ACCOUNT_NAMESPACE} azure.workload.identity/tenant-id="${APPLICATION_TENANT_ID}" --overwrite
az ad app federated-credential create --id ${APPLICATION_OBJECT_ID} --parameters @params.json

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: quick-start
  namespace: ${SERVICE_ACCOUNT_NAMESPACE}
spec:
  serviceAccountName: ${SERVICE_ACCOUNT_NAME}
  containers:
    - image: ghcr.io/azure/azure-workload-identity/msal-go
      name: oidc
      env:
      - name: KEYVAULT_NAME
        value: ${KEYVAULT_NAME}
      - name: KEYVAULT_URL
        value: ${KEYVAULT_URL}
      - name: SECRET_NAME
        value: ${KEYVAULT_SECRET_NAME}
  nodeSelector:
    kubernetes.io/os: linux
EOF