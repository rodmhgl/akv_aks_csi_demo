locals {
  resource_group_name = "rg-${var.prefix}-aksakv"
  aks_name            = "${var.prefix}-aks1"
  dns_prefix          = "${var.prefix}aks1"
}

resource "azurerm_resource_group" "this" {
  name     = local.resource_group_name
  location = var.location
}
