output "subnet_ids" {
  description = "Map of Subnet IDs"
  value       = { for key, subnet in azurerm_subnet.subnet : key => subnet.id }
}

output "subnet_names" {
  description = "Map of Subnet Names"
  value       = { for key, subnet in azurerm_subnet.subnet : key => subnet.name }
}

output "subnet_address_prefixes" {
  description = "Map of Subnet Address Prefixes"
  value       = { for key, subnet in azurerm_subnet.subnet : key => subnet.address_prefixes }
}
