output "virtual_machine_ids" {
  description = "Map of Virtual Machine IDs"
  value       = { for key, vm in azurerm_virtual_machine.vmb1 : key => vm.id }
}
