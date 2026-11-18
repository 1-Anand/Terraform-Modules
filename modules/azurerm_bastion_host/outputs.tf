output "bastion_host_ids" {
  description = "Map of Bastion Host IDs"
  value       = { for key, bastion in azurerm_bastion_host.bastionblock1 : key => bastion.id }
}

output "bastion_host_dns_names" {
  description = "Map of FQDNs for the Azure Bastion hosts"
  value       = { for key, bastion in azurerm_bastion_host.bastionblock1 : key => bastion.dns_name }
}
