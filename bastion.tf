locals {
  bastion_ip_name   = "${var.prefix}bastionpip"
  bastion_host_name = "${var.prefix}bastion"
}

resource "azurerm_public_ip" "that" {
  name                = local.bastion_ip_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_bastion_host" "that" {
  name                = local.bastion_host_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "Standard"
  copy_paste_enabled  = true
  file_copy_enabled   = true
  ip_connect_enabled  = true
  # Tunneling Enabled is required to use Native Client connections
  tunneling_enabled      = true
  shareable_link_enabled = true

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion.id
    public_ip_address_id = azurerm_public_ip.that.id
  }
}