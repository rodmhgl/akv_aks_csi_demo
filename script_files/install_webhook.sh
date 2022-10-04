# Commands taken from https://azure.github.io/azure-workload-identity/docs/installation/mutating-admission-webhook.html
# Must be run **after** set_env_var.sh as it will consume those vars
helm repo add azure-workload-identity https://azure.github.io/azure-workload-identity/charts
helm repo update
helm install workload-identity-webhook azure-workload-identity/workload-identity-webhook \
    --namespace azure-workload-identity-system \
    --create-namespace \
    --set azureTenantID="${AZURE_TENANT_ID}"

curl -sL https://github.com/Azure/azure-workload-identity/releases/download/v0.13.0/azure-wi-webhook.yaml | envsubst | kubectl apply -f -
