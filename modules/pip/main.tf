resource "azurerm_public_ip" "pipb1" {
    for_each = var.pip
    name = each.value.name
    location = each.value.location
    resource_group_name = each.value.resource_group_name
    allocation_method = each.value.allocation_method
    sku                 = each.value.sku
}



output "public_ip_ids" {
  value = { for key, pip in azurerm_public_ip.pipb1 : key => pip.id }
}