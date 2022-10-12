resource "azurerm_network_interface" "this" {
  # checkov:skip=CKV_AZURE_119: ADD REASON
  name                = "this-nic"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.this.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.this.id
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_linux_virtual_machine" "this" {
  # checkov:skip=CKV_AZURE_50: AADSSHLoginforLinux extension in use
  name                = "this-machine"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.this.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = tls_private_key.ssh_key.public_key_openssh # file("~/.ssh/id_rsa.pub")
  }

  identity {
    type = "SystemAssigned"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_virtual_machine_extension" "aad_ssh_login" {
  name                       = "${azurerm_linux_virtual_machine.this.name}-AADSSHLoginForLinux"
  publisher                  = "Microsoft.Azure.ActiveDirectory"
  type                       = "AADSSHLoginForLinux"
  type_handler_version       = "1.0"
  virtual_machine_id         = azurerm_linux_virtual_machine.this.id
  auto_upgrade_minor_version = true
}

resource "azurerm_role_assignment" "assign-vm-role" {
  scope                = azurerm_linux_virtual_machine.this.id
  role_definition_name = "Virtual Machine User Login"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_public_ip" "this" {
  name                = "acceptanceTestPublicIp1"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  allocation_method   = "Static"

  tags = {
    environment = var.environment
  }
}

# Create (and display) an SSH key
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_key_vault_secret" "vm_ssh_key" {
  content_type    = "password"
  name            = "${azurerm_linux_virtual_machine.this.name}-sshkey"
  value           = tls_private_key.ssh_key.private_key_openssh
  key_vault_id    = azurerm_key_vault.this.id
  expiration_date = "2023-10-08T23:59:59Z"
}