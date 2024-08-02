resource "azurerm_resource_group" "rgs" {
    for_each = var.rg-name
    name = each.value.name
    location = each.value.location
}