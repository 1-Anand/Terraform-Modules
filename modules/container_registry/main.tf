resource "azurerm_container_registry" "acr" {
  for_each            = var.acr-list
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  sku                 = each.value.sku
  admin_enabled       = lookup(each.value, "admin_enabled", true)
}

output "acr_ids" {
  value = { for key, acr in azurerm_container_registry.acr : key => acr.id }
}
