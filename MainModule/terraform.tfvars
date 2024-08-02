resource_groups = {
  rg1 = {
    name     = "prod-rg-centralindia"
    location = "centralindia"
  }
}

virtual_networks = {
  vnet1 = {
    name                = "prod-vnet-centralindia"
    location            = "centralindia"
    resource_group_name = "prod-rg-centralindia"
    address_space       = ["10.0.0.0/16"]
  }
}

subnets = {
  subnet1 = {
    name                 = "prod-subnet-centralindia"
    resource_group_name  = "prod-rg-centralindia"
    virtual_network_name = "prod-vnet-centralindia"
    address_prefixes     = ["10.0.2.0/24"]
  }
}
