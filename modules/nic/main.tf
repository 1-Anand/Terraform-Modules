
resource "azurerm_network_interface" "nicB1" {
  for_each = var.nic-card

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = each.value.ip_configuration.name
    subnet_id                     = var.subnet_ids[each.value.subnet_key]
    private_ip_address_allocation = "Dynamic"
    primary                       = each.value.primary  # Set primary NIC
  }
}


output "network_interface_ids" {
  value = { for key, nic in azurerm_network_interface.nicB1 : key => nic.id }
}