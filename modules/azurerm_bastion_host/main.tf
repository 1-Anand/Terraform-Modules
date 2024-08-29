
resource "azurerm_bastion_host" "bastionblock1" {
    for_each = var.bastionhost
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                 = each.value.ip_configuration.name
    subnet_id            = var.subnet_ids[each.value.subnet_key]
    public_ip_address_id = var.public_ip_ids[each.value.pip_key]                    #each.value.ip_configuration.public_ip_address_id
  }
}