output "kube_config" {
  value       = azurerm_kubernetes_cluster.this.kube_config_raw
  description = "Raw Kube config file to use for access to the cluster."
  sensitive   = true
}

output "oidc_issuer_url" {
  value       = azurerm_kubernetes_cluster.this.oidc_issuer_url
  description = "OIDC Issuer URL to be used for token issuance."
}

output "key_vault_name" {
  value       = azurerm_key_vault.this.name
  description = "Name of the Key Vault."
}

output "resource_group_name" {
  value       = azurerm_resource_group.this.name
  description = "Name of the Resource Group."
}