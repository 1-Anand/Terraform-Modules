output "resource_group_ids" {
  description = "Map of Resource Group IDs"
  value       = { for key, rg in azurerm_resource_group.rg : key => rg.id }
}

output "resource_group_names" {
  description = "Map of Resource Group Names"
  value       = { for key, rg in azurerm_resource_group.rg : key => rg.name }
}
