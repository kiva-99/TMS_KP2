output "vm_public_ip" {
  value = module.kp2-vm.vm_public_ip
}

output "vm_private_ip" {
  value = module.kp2-vm.vm_internal_ip
}

output "used_network_id" {
  value = local.network_id
}

output "used_subnet_id" {
  value = local.subnet_id
}
