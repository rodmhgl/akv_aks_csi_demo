# This resource will create your environment variable file for you.
# You can then load the variables into your environment by running
# source ./set_env_vars.sh
# If you aren't running Terraform from Linux / WSL,
# you can comment this portion out.
# This can be made OS-agnostic but not for an MVP :)
resource "null_resource" "output_file" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = templatefile("./script_files/set_env_vars.tpl", {
      KEYVAULT_NAME           = azurerm_key_vault.this.name,
      KEYVAULT_SECRET         = azurerm_key_vault_secret.this.name,
      KEYVAULT_URL            = azurerm_key_vault.this.vault_uri,
      OIDC                    = azurerm_kubernetes_cluster.this.oidc_issuer_url,
      RESOURCE_GROUP_NAME     = azurerm_resource_group.this.name,
      RESOURCE_GROUP_LOCATION = azurerm_resource_group.this.location,
      APPLICATION_NAME        = azuread_application.this.display_name,
      APPLICATION_CLIENT_ID   = azuread_service_principal.this.application_id,
      APPLICATION_OBJECT_ID   = azuread_service_principal.this.object_id,
      AZURE_SUBSCRIPTION_ID   = data.azurerm_client_config.current.subscription_id,
      AZURE_TENANT_ID         = data.azurerm_client_config.current.tenant_id,
    })
    interpreter = ["bash", "-c"]
  }
}