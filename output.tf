output "kube_config" {
  value       = azurerm_kubernetes_cluster.this.kube_config_raw
  description = "Raw Kube config file to use for access to the cluster."
  sensitive   = true
}