output "client_certificate" {
  value     = azurerm_kubernetes_cluster.this.kube_config[0].client_certificate
  sensitive = true
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.this.kube_config_raw
  sensitive = true
}

output "oidc_issuer_url" {
  value = azurerm_kubernetes_cluster.this.oidc_issuer_url
}

output "key_vault_name" {
  value = azurerm_key_vault.this.name
}

output "resource_group_name" {
  value = azurerm_resource_group.this.name
}