output "Avi_controller_ips_dhcp_cluster" {
  value = var.dhcp == true && var.avi.config.cluster== true ? vsphere_virtual_machine.controller_dhcp_cluster[*].default_ip_address  : null
}

output "Avi_controller_ips_dhcp_standalone" {
  value = var.dhcp == true && var.avi.config.cluster== false ? vsphere_virtual_machine.controller_dhcp_standalone[*].default_ip_address  : null
}

output "Avi_controller_ips_static_cluster" {
  value = var.dhcp == false && var.avi.config.cluster== true ? vsphere_virtual_machine.controller_static_cluster[*].default_ip_address  : null
}

output "Avi_controller_ips_static_standalone" {
  value = var.dhcp == false && var.avi.config.cluster== false ? vsphere_virtual_machine.controller_static_standalone[*].default_ip_address  : null
}

output "destroy_command" {
  value = "ansible-playbook aviAbsent/local.yml --extra-vars @~/.creds.json ; terraform destroy -auto-approve -var-file=avi.json"
}
