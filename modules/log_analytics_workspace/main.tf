resource "azurerm_log_analytics_workspace" "law" {
  for_each            = var.log-analytics-list
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = lookup(each.value, "sku", "PerGB2018")
  retention_in_days   = lookup(each.value, "retention_in_days", 30)
}
