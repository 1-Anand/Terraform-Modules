output "acr_ids" {
  description = "Map of Azure Container Registry IDs"
  value       = { for key, acr in azurerm_container_registry.acr : key => acr.id }
}

output "acr_login_servers" {
  description = "Map of ACR login server endpoints for Docker/Helm pushes"
  value       = { for key, acr in azurerm_container_registry.acr : key => acr.login_server }
}
