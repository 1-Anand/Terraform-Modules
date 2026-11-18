output "vnet_ids" {
  description = "Map of Virtual Network IDs provisioned by the module"
  value       = { for key, vnet in azurerm_virtual_network.vnet101 : key => vnet.id }
}

output "vnet_names" {
  description = "Map of Virtual Network names"
  value       = { for key, vnet in azurerm_virtual_network.vnet101 : key => vnet.name }
}

output "vnet_address_spaces" {
  description = "Map of address spaces for the virtual networks"
  value       = { for key, vnet in azurerm_virtual_network.vnet101 : key => vnet.address_space }
}
