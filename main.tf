locals {
  resource_group_name = "rg-${var.prefix}-aksakv"
  aks_name            = "${var.prefix}-aks1"
  dns_prefix          = "${var.prefix}aks1"
}

resource "azurerm_resource_group" "this" {
  name     = local.resource_group_name
  location = var.location
}

# Creates k8s cluster with OIDC enabled and key_vault_secrets_provider
resource "azurerm_kubernetes_cluster" "this" {
  name                    = local.aks_name
  location                = azurerm_resource_group.this.location
  resource_group_name     = azurerm_resource_group.this.name
  dns_prefix              = local.dns_prefix
  private_cluster_enabled = var.private_aks_cluster
  local_account_disabled  = var.aks_admin_disabled
  # OIDC Issuer required for AD Workload Identity
  oidc_issuer_enabled = true

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  # key_vault_secrets_provider is required for the AKV addon
  key_vault_secrets_provider {
    secret_rotation_enabled  = true
    secret_rotation_interval = "2m"
  }

  tags = {
    Environment = "Production"
  }
}
