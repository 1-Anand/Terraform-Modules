# modules/subnet/main.tf
resource "azurerm_subnet" "subnet" {
  for_each = var.subnets

  name                 = each.value.name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
  address_prefixes     = each.value.address_prefixes
}

output "subnet_ids" {
  value = { for key, subnet in azurerm_subnet.subnet : key => subnet.id }
}

