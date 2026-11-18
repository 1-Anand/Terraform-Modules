output "aks_ids" {
  description = "Map of Azure Kubernetes Service cluster IDs"
  value       = { for key, aks in azurerm_kubernetes_cluster.aks : key => aks.id }
}

output "aks_names" {
  description = "Map of AKS cluster names"
  value       = { for key, aks in azurerm_kubernetes_cluster.aks : key => aks.name }
}

output "aks_principal_ids" {
  description = "Map of System-Assigned Managed Identity Principal IDs for the AKS clusters"
  value       = { for key, aks in azurerm_kubernetes_cluster.aks : key => aks.identity[0].principal_id }
}

output "aks_kube_config_raw" {
  description = "Map of raw kubeconfig for cluster access (sensitive)"
  value       = { for key, aks in azurerm_kubernetes_cluster.aks : key => aks.kube_config_raw }
  sensitive   = true
}
