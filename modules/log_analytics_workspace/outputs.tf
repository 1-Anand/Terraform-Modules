output "log_analytics_ids" {
  description = "Map of Log Analytics Workspace IDs"
  value       = { for key, law in azurerm_log_analytics_workspace.law : key => law.id }
}

output "log_analytics_workspace_ids" {
  description = "Map of Log Analytics Workspace Resource IDs"
  value       = { for key, law in azurerm_log_analytics_workspace.law : key => law.workspace_id }
}
