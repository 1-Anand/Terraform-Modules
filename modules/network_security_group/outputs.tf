output "nsg_ids" {
  description = "Map of Network Security Group IDs"
  value       = { for key, nsg in azurerm_network_security_group.nsg : key => nsg.id }
}

output "nsg_names" {
  description = "Map of Network Security Group Names"
  value       = { for key, nsg in azurerm_network_security_group.nsg : key => nsg.name }
}
