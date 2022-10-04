cat <<EOF >>./set_env_vars.sh
# environment variables for the Azure Key Vault resource
export KEYVAULT_NAME="${KEYVAULT_NAME}"
export KEYVAULT_SECRET_NAME="${KEYVAULT_SECRET}"
export RESOURCE_GROUP="${RESOURCE_GROUP_NAME}"
export LOCATION="${RESOURCE_GROUP_LOCATION}"

# environment variables for the AAD application
export APPLICATION_NAME="${APPLICATION_NAME}"

# environment variables for the Kubernetes service account & federated identity credential
export SERVICE_ACCOUNT_ISSUER="${OIDC}"
export SERVICE_ACCOUNT_NAMESPACE="default"
export SERVICE_ACCOUNT_NAME="workload-identity-sa"

export APPLICATION_CLIENT_ID="${APPLICATION_CLIENT_ID}"
export APPLICATION_OBJECT_ID="${APPLICATION_OBJECT_ID}"
export AZURE_SUBSCRIPTION_ID="${AZURE_SUBSCRIPTION_ID}"
export AZURE_TENANT_ID="${AZURE_TENANT_ID}"

export KEYVAULT_URL="$(az keyvault show -g ${RESOURCE_GROUP_NAME} -n ${KEYVAULT_NAME} --query properties.vaultUri -o tsv)"
EOF
