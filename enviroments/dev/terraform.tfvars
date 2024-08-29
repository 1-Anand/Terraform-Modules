map-rg-list = {
  rg1 = {
    name     = "bhushan1"
    location = "centralindia"
  }
}

map-storageac-list = {
  storage1 = {
    name                     = "apnastorageaccount"
    resource_group_name      = "bhushan1"
    location                 = "centralindia"
    account_tier             = "Standard"
    account_replication_type = "LRS"

  }
}

map-virtualnetwork-list = {
  vnet1 = {
    name                = "vent-112"
    location            = "centralindia"
    resource_group_name = "bhushan1"
    address_space       = ["10.0.0.0/16"]
    dns_servers         = ["10.0.0.4", "10.0.0.5"]

  }

}
map_subnet_list = {
  subnet-01 = {
    name                 = "subnet-011"
    resource_group_name  = "bhushan1"
    virtual_network_name = "vent-112"
    address_prefixes     = ["10.0.2.0/24"]
  }
  subnet-02 = {
    name                 = "subnet-012"
    resource_group_name  = "bhushan1"
    virtual_network_name = "vent-112"
    address_prefixes     = ["10.0.3.0/24"]
  }
  AzureBastionSubnet = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "bhushan1"
    virtual_network_name = "vent-112"
    address_prefixes     = ["10.0.4.0/26"]
  }
}

map_nic = {
  nic-101 = {
    name                = "nic-101"
    resource_group_name = "bhushan1"
    location            = "centralindia"
    subnet_key          = "subnet-01"
    primary             = true # Set this NIC as the primary one
    ip_configuration = {
      name = "ipconfig1"
    }
  }
  nic-102 = {
    name                = "nic-102"
    resource_group_name = "bhushan1"
    location            = "centralindia"
    subnet_key          = "subnet-01"
    primary             = false # This NIC is not the primary
    ip_configuration = {
      name = "ipconfig1"
    }
  }
  nic-103 = {
    name                = "nic-103"
    resource_group_name = "bhushan1"
    location            = "centralindia"
    subnet_key          = "subnet-02"
    primary             = false # This NIC is not the primary
    ip_configuration = {
      name = "ipconfig1"
    }
  }
}

map-pip = {
  pip01 = {
    name                = "public-ip"
    location            = "centralindia"
    resource_group_name = "bhushan1"
    allocation_method   = "Static"
    sku                 = "Standard"
  }
}

map-bastionhost = {
  bastionhost1 = {
    name                = "AzureBastion"
    location            = "centralindia"
    resource_group_name = "bhushan1"
    subnet_key          = "AzureBastionSubnet"
    pip_key             = "pip01"
    ip_configuration = {
      name = "configuration"
    }
  }
}


virtual_machine = {
  frontend = {
    name                = "frontend-VM"
    location            = "centralindia"
    resource_group_name = "bhushan1"
    vm_size             = "Standard_DS1_v2"
    nic_keys            = ["nic-101"]
    delete_os_disk_on_termination    = true
    delete_data_disks_on_termination = true
    storage_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-focal"
      sku       = "20_04-lts"
      version   = "latest"
    }
    storage_os_disk = {
      name              = "frontend-osdisk"
      caching           = "ReadWrite"
      create_option     = "FromImage"
      managed_disk_type = "Standard_LRS"
    }
    os_profile = {
      computer_name  = "frontend-hostname"
      admin_username = "testadmin"
      admin_password = "Password1234!"
                                                                       # custom_data = <<-EOF    if we are not using script.sh or .yaml  than we directly bash script here 
                                                                       #     #!/bin/bash
                                                                       #     sudo apt-get update
                                                                       #     sudo apt-get install -y nginx
                                                                       #     EOF
    }
    os_profile_linux_config = {  # Add this block
      disable_password_authentication = false
    }
    install_script = "install_nginx.sh"
  }
  backend = {
    name                = "backend-VM"
    location            = "centralindia"
    resource_group_name = "bhushan1"
    vm_size             = "Standard_DS1_v2"
    nic_keys            = ["nic-102"]
    delete_os_disk_on_termination    = true
    delete_data_disks_on_termination = true
    storage_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-focal"
      sku       = "20_04-lts"
      version   = "latest"
    }
    storage_os_disk = {
      name              = "backend-osdisk"
      caching           = "ReadWrite"
      create_option     = "FromImage"
      managed_disk_type = "Standard_LRS"
    }
    os_profile = {
      computer_name  = "backend-hostname"
      admin_username = "testadmin"
      admin_password = "Password1234!"
    }
    os_profile_linux_config = {  # Add this block
      disable_password_authentication = false
    }
    install_script = "install_pip.sh"
  }
}
