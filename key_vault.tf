# Cheap and easy way to get randomized key vault name
# Change the value of var.akv_previs to regenerates
resource "random_integer" "akvname" {
  min = 1
  max = 50000
  keepers = {
    akv_id = var.akv_prefix
  }
}

# Key Vault that the k8s pod will pull secrets from
resource "azurerm_key_vault" "this" {
  # checkov:skip=CKV_AZURE_109: LAB AKV
  name                        = "keyvault${random_integer.akvname.result}"
  location                    = azurerm_resource_group.this.location
  resource_group_name         = azurerm_resource_group.this.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true

  sku_name = "standard"

  tags = {
    environment = var.environment
  }
}

# Set access policies for the user running Terraform
resource "azurerm_key_vault_access_policy" "this" {
  key_vault_id            = azurerm_key_vault.this.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = data.azurerm_client_config.current.object_id
  key_permissions         = var.admin_key_permissions
  secret_permissions      = var.admin_secret_permissions
  storage_permissions     = var.admin_storage_permissions
  certificate_permissions = var.admin_certificate_permissions
}

# Set access policies for the AAD Application
resource "azurerm_key_vault_access_policy" "that" {
  key_vault_id            = azurerm_key_vault.this.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = azuread_service_principal.this.object_id
  key_permissions         = var.aad_key_permissions
  secret_permissions      = var.aad_secret_permissions
  storage_permissions     = var.aad_storage_permissions
  certificate_permissions = var.aad_certificate_permissions
}


# Create test secret for k8s pod to pull
resource "azurerm_key_vault_secret" "this" {
  name            = "my-secret"
  value           = "Hello!"
  key_vault_id    = azurerm_key_vault.this.id
  expiration_date = "2023-10-31T00:00:00Z"
  content_type    = "password"

  tags = {
    file-encoding = "utf-8"
    environment   = var.environment
  }

  depends_on = [
    azurerm_key_vault_access_policy.this,
    azurerm_key_vault_access_policy.that,
  ]
}