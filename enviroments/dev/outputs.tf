output "resource_group_names" {
  description = "Names of the provisioned Azure Resource Groups"
  value       = module.map-rg-lists.resource_group_names
}

output "virtual_network_ids" {
  description = "IDs of the provisioned Virtual Networks"
  value       = module.map-virtualnetwork-lists.vnet_ids
}

output "subnet_ids" {
  description = "Subnet IDs for application and infra tiers"
  value       = module.map-subnet-list.subnet_ids
}

output "aks_cluster_names" {
  description = "Provisioned AKS cluster names"
  value       = module.aks.aks_names
}

output "aks_cluster_ids" {
  description = "Provisioned AKS cluster resource IDs"
  value       = module.aks.aks_ids
}

output "container_registry_login_server" {
  description = "Azure Container Registry login servers"
  value       = module.acr.acr_login_servers
}

output "key_vault_uris" {
  description = "Azure Key Vault URIs for application secrets"
  value       = module.keyvault.key_vault_uris
}
