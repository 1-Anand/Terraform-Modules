data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  for_each                   = var.keyvault-list
  name                       = each.value.name
  location                   = each.value.location
  resource_group_name        = each.value.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = each.value.sku_name
  soft_delete_retention_days = lookup(each.value, "soft_delete_retention_days", 7)
  purge_protection_enabled   = lookup(each.value, "purge_protection_enabled", false)
}

output "key_vault_ids" {
  value = { for key, kv in azurerm_key_vault.kv : key => kv.id }
}
