resource "azurerm_virtual_machine" "vmb1" {
  for_each = var.virtual_machine

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  vm_size             = each.value.vm_size

  network_interface_ids = [
    for nic_key in each.value.nic_keys : var.network_interface_ids[nic_key]
  ]

  primary_network_interface_id = var.network_interface_ids[each.value.nic_keys[0]]

  delete_os_disk_on_termination    = each.value.delete_os_disk_on_termination
  delete_data_disks_on_termination = each.value.delete_data_disks_on_termination

  storage_image_reference {
    publisher = each.value.storage_image_reference.publisher
    offer     = each.value.storage_image_reference.offer
    sku       = each.value.storage_image_reference.sku
    version   = each.value.storage_image_reference.version
  }

  storage_os_disk {
    name              = "${each.value.storage_os_disk.name}-${each.key}"
    caching           = each.value.storage_os_disk.caching
    create_option     = each.value.storage_os_disk.create_option
    managed_disk_type = each.value.storage_os_disk.managed_disk_type
  }

  os_profile {
    computer_name  = each.value.os_profile.computer_name
    admin_username = each.value.os_profile.admin_username
    admin_password = each.value.os_profile.admin_password
  #  custom_data = file("${path.module}/../../scripts/cloud_init.yaml") if we are using only one script
   custom_data = file("${path.module}/../../scripts/${each.value.install_script}")
  }


  os_profile_linux_config {
    disable_password_authentication = each.value.os_profile_linux_config.disable_password_authentication
    
  }

  tags = {
    environment = "staging"
  }
}


# resource "azurerm_virtual_machine" "vmb1" {
#   for_each = var.virtual-machine

#   name                  = each.value.name
#   location              = each.value.location
#   resource_group_name   = each.value.resource_group_name
#   # network_interface_ids = [var.network_interface_ids[each.value.nic_key]]  # if you are using only one nic card is single string.

#   network_interface_ids = [for nic_key in each.value.nic_keys : var.network_interface_ids[nic_key]]


#   vm_size               = each.value.vm_size




#   # Uncomment this line to delete the OS disk automatically when deleting the VM
#   delete_os_disk_on_termination = true

#   # Uncomment this line to delete the data disks automatically when deleting the VM
#   delete_data_disks_on_termination = true

#   storage_image_reference {

#     publisher = each.value.storage_image_reference.publisher
#     offer     = each.value.storage_image_reference.offer
#     sku       = each.value.storage_image_reference.sku
#     version   = each.value.storage_image_reference.version
#   }
#   storage_os_disk {
#     name              = "${each.value.storage_os_disk.name}-${each.key}"
#     caching           = each.value.storage_os_disk.caching
#     create_option     = each.value.storage_os_disk.create_option
#     managed_disk_type = each.value.storage_os_disk.managed_disk_type

#   }
#   os_profile {
#     computer_name  = each.value.os_profile.computer_name
#     admin_username = each.value.os_profile.admin_username
#     admin_password = each.value.os_profile.admin_password

#     # custom_data = file("${path.module}/../../scripts/install_nginx.sh")  for Bash Scrip | We are defining here because we can't pass this in terraform.tfvars
#     custom_data = file("${path.module}/../../scripts/cloud_init.yaml")     # For Yaml Playbook | We are defining here because we can't pass this in terraform.tfvars

#     # custom_data = each.value.os_profile.custom_data  # iF we are using this than we have to pass value in terraform.tfvars , Please check Enviroment/dev/terraform.tfvars
#   }
#   os_profile_linux_config {
#     disable_password_authentication = each.value.os_profile_linux_config.disable_password_authentication
#   }



# }
