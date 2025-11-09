output "vm_name" {
  description = "VM Name"
  value       = vsphere_virtual_machine.vm.name
}

output "default_ip_address" {
  description = "VM IP address"
  value       = vsphere_virtual_machine.vm.default_ip_address
}








