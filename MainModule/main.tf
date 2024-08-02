module "resource_groups" {
    source = "../ResourceGroup"
    rg-name = var.resource_groups

}

module "virtual_networks" {
    depends_on = [ module.resource_groups ]
    source = "../VirtualNetwork"
    vnet = var.virtual_networks
}

module "subnets" {
    depends_on = [ module.virtual_networks ]
    source = "../Subnet"
    subnet = var.subnets
}