output "public_ip_ids" {
  description = "Map of Public IP resource IDs"
  value       = { for key, pip in azurerm_public_ip.pipb1 : key => pip.id }
}

output "public_ip_addresses" {
  description = "Map of allocated IP addresses"
  value       = { for key, pip in azurerm_public_ip.pipb1 : key => pip.ip_address }
}
