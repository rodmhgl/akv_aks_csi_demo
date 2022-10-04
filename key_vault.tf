resource "random_integer" "akvname" {
  min = 1
  max = 50000
  keepers = {
    akv_id = var.akv_prefix
  }
}

resource "azurerm_key_vault" "this" {
  name                        = "keyvault${random_integer.akvname.result}"
  location                    = azurerm_resource_group.this.location
  resource_group_name         = azurerm_resource_group.this.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true

  sku_name = "standard"
}

resource "azurerm_key_vault_access_policy" "this" {
  key_vault_id        = azurerm_key_vault.this.id
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = data.azurerm_client_config.current.object_id
  key_permissions     = ["Get", "List", ]
  secret_permissions  = ["Get", "List", "Set", ]
  storage_permissions = ["Get", "List", "Set", ]
}

resource "azurerm_key_vault_access_policy" "that" {
  key_vault_id        = azurerm_key_vault.this.id
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = azuread_service_principal.this.object_id
  key_permissions     = ["Get", "List", ]
  secret_permissions  = ["Get", "List", "Set", ]
  storage_permissions = ["Get", "List", "Set", ]
}

resource "azurerm_key_vault_secret" "example" {
  name            = "my-secret"
  value           = "Hello!"
  key_vault_id    = azurerm_key_vault.this.id
  expiration_date = "2023-10-31T00:00:00Z"
  content_type    = "password"
}