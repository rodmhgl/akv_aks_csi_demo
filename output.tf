output "kube_config" {
  value       = azurerm_kubernetes_cluster.this.kube_config_raw
  description = "Raw Kube config file to use for access to the cluster."
  sensitive   = true
}

output "private_key_retrieval_command_line" {
  value       = "az keyvault secret show --name ${azurerm_key_vault_secret.vm_ssh_key.name} --vault-name ${azurerm_key_vault.this.name} --query \"value\""
  description = "Command line to retrieve private key."
}

output "bastion_connect_command_line" {
  value       = "az network bastion ssh --resource-group ${azurerm_resource_group.this.name} --auth-type AAD --name ${azurerm_bastion_host.that.name} --target-resource-id ${azurerm_linux_virtual_machine.this.id}"
  description = "Command line to connect to the VM via the Bastion using AAD SSO."
}