output "storage_account_ids" {
  description = "Map of Storage Account IDs"
  value       = { for key, sa in azurerm_storage_account.StorageAccount : key => sa.id }
}

output "primary_blob_endpoints" {
  description = "Map of primary blob endpoints for storage accounts"
  value       = { for key, sa in azurerm_storage_account.StorageAccount : key => sa.primary_blob_endpoint }
}
