output "network_interface_ids" {
  description = "Map of Network Interface IDs"
  value       = { for key, nic in azurerm_network_interface.nicB1 : key => nic.id }
}

output "network_interface_private_ips" {
  description = "Map of private IP addresses allocated to NICs"
  value       = { for key, nic in azurerm_network_interface.nicB1 : key => nic.private_ip_address }
}
