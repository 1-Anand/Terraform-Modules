
module "map-rg-lists" {
  source  = "../../modules/resource_group"
  rg-list = var.map-rg-list
}

module "map-storageac-lists" {
  depends_on          = [module.map-rg-lists]
  source              = "../../modules/storage_account"
  StorageAccount-List = var.map-storageac-list
}

module "map-virtualnetwork-lists" {
  depends_on          = [module.map-rg-lists]
  source              = "../../modules/virtual_network"
  VirtualNetwork-List = var.map-virtualnetwork-list
}


module "map-subnet-list" {
  depends_on = [module.map-virtualnetwork-lists]
  source     = "../../modules/subnet"
  subnets    = var.map_subnet_list
}





module "nics" {
  depends_on = [module.map-subnet-list]
  source     = "../../modules/nic"
  nic-card   = var.map_nic
  subnet_ids = module.map-subnet-list.subnet_ids
}


module "map-publicip" {
  depends_on = [module.map-rg-lists]
  source     = "../../modules/pip"
  pip        = var.map-pip

}

module "bastionhost" {
  depends_on = [module.map-publicip, module.map-subnet-list]

  source        = "../../modules/azurerm_bastion_host"
  bastionhost   = var.map-bastionhost
  subnet_ids    = module.map-subnet-list.subnet_ids
  public_ip_ids = module.map-publicip.public_ip_ids
}



module "virtualmachine" {
  depends_on            = [module.nics]
  source                = "../../modules/virtual_machine"
  virtual_machine       = var.virtual_machine
  network_interface_ids = module.nics.network_interface_ids
}



