resource "azurerm_network_security_group" "nsg" {
  for_each            = var.nsg-list
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
}

output "nsg_ids" {
  value = { for key, nsg in azurerm_network_security_group.nsg : key => nsg.id }
}
