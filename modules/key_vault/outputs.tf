output "key_vault_ids" {
  description = "Map of Key Vault IDs"
  value       = { for key, kv in azurerm_key_vault.kv : key => kv.id }
}

output "key_vault_uris" {
  description = "Map of Key Vault URIs for application secret references"
  value       = { for key, kv in azurerm_key_vault.kv : key => kv.vault_uri }
}
