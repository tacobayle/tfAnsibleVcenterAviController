data "template_file" "avi_yaml_values_dhcp_cluster" {
  template = file("templates/avi_yaml_values.yml.template")
  count            = var.dhcp == true && var.avi.config.cluster == true ? 1 : 0
  vars = {
    controller_ips = jsonencode(vsphere_virtual_machine.controller_dhcp_cluster.*.default_ip_address)
    controller_ntp = jsonencode(var.controller.ntp)
    controller_dns = jsonencode(var.controller.dns)
    cluster = jsonencode(var.avi.config.cluster)
    avi_password = var.avi_password
    avi_old_password = var.avi_old_password
    avi_version = var.avi.config.version
    avi_username = var.avi.config.username
    vsphere_username = var.vsphere_username
    vsphere_password = var.vsphere_password
    vsphere_server = var.vsphere_server
    domains = jsonencode(var.avi.config.vcenter.domains)
    cloud_name = var.avi.config.vcenter.cloud.name
    dc = var.vcenter_dc
    dchp_enabled = jsonencode(var.avi.config.vcenter.cloud.dhcp_enabled)
    network_management = jsonencode(var.avi.config.vcenter.cloud.network_management)
    network_vip = jsonencode(var.avi.config.vcenter.cloud.network_vip)
    service_engine_groups = jsonencode(var.avi.config.vcenter.cloud.service_engine_groups)
    pools = jsonencode(var.avi.config.vcenter.cloud.pools)
    pool_groups = jsonencode(var.avi.config.vcenter.cloud.pool_groups)
    virtual_services = jsonencode(var.avi.config.vcenter.cloud.virtual_services)
  }
}

resource "null_resource" "dump_locally_avi_yaml_values_dhcp_cluster" {
  count            = var.dhcp == true && var.avi.config.cluster == true ? 1 : 0
  provisioner "local-exec" {
    command = "cat > avi.yml <<EOL\n${data.template_file.avi_yaml_values_dhcp_cluster[count.index].rendered}\nEOL"
  }
}

data "template_file" "avi_yaml_values_dhcp_standalone" {
  template = file("templates/avi_yaml_values.yml.template")
  count            = var.dhcp == true && var.avi.config.cluster == false ? 1 : 0
  vars = {
    controller_ips = jsonencode(vsphere_virtual_machine.controller_dhcp_standalone.*.default_ip_address)
    controller_ntp = jsonencode(var.controller.ntp)
    controller_dns = jsonencode(var.controller.dns)
    cluster = jsonencode(var.avi.config.cluster)
    avi_password = var.avi_password
    avi_old_password = var.avi_old_password
    avi_version = var.avi.config.version
    avi_username = var.avi.config.username
    vsphere_username = var.vsphere_username
    vsphere_password = var.vsphere_password
    vsphere_server = var.vsphere_server
    domains = jsonencode(var.avi.config.vcenter.domains)
    cloud_name = var.avi.config.vcenter.cloud.name
    dc = var.vcenter_dc
    dchp_enabled = jsonencode(var.avi.config.vcenter.cloud.dhcp_enabled)
    network_management = jsonencode(var.avi.config.vcenter.cloud.network_management)
    network_vip = jsonencode(var.avi.config.vcenter.cloud.network_vip)
    service_engine_groups = jsonencode(var.avi.config.vcenter.cloud.service_engine_groups)
    pools = jsonencode(var.avi.config.vcenter.cloud.pools)
    pool_groups = jsonencode(var.avi.config.vcenter.cloud.pool_groups)
    virtual_services = jsonencode(var.avi.config.vcenter.cloud.virtual_services)
  }
}

resource "null_resource" "dump_locally_avi_yaml_values_dhcp_standalone" {
  count            = var.dhcp == true && var.avi.config.cluster == false ? 1 : 0
  provisioner "local-exec" {
    command = "cat > avi.yml <<EOL\n${data.template_file.avi_yaml_values_dhcp_standalone[count.index].rendered}\nEOL"
  }
}

data "template_file" "avi_yaml_values_static_cluster" {
  template = file("templates/avi_yaml_values.yml.template")
  count            = var.dhcp == false && var.avi.config.cluster == true ? 1 : 0
  vars = {
    controller_ips = jsonencode(vsphere_virtual_machine.controller_static_cluster.*.default_ip_address)
    controller_ntp = jsonencode(var.controller.ntp)
    controller_dns = jsonencode(var.controller.dns)
    cluster = jsonencode(var.avi.config.cluster)
    avi_password = var.avi_password
    avi_old_password = var.avi_old_password
    avi_version = var.avi.config.version
    avi_username = var.avi.config.username
    vsphere_username = var.vsphere_username
    vsphere_password = var.vsphere_password
    vsphere_server = var.vsphere_server
    domains = jsonencode(var.avi.config.vcenter.domains)
    cloud_name = var.avi.config.vcenter.cloud.name
    dc = var.vcenter_dc
    dchp_enabled = jsonencode(var.avi.config.vcenter.cloud.dhcp_enabled)
    network_management = jsonencode(var.avi.config.vcenter.cloud.network_management)
    network_vip = jsonencode(var.avi.config.vcenter.cloud.network_vip)
    network_backend = jsonencode(var.avi.config.vcenter.cloud.network_backend)
    service_engine_groups = jsonencode(var.avi.config.vcenter.cloud.service_engine_groups)
    pools = jsonencode(var.avi.config.vcenter.cloud.pools)
    pool_groups = jsonencode(var.avi.config.vcenter.cloud.pool_groups)
    virtual_services = jsonencode(var.avi.config.vcenter.cloud.virtual_services)
  }
}

resource "null_resource" "dump_locally_avi_yaml_values_static_cluster" {
  count            = var.dhcp == false && var.avi.config.cluster == true ? 1 : 0
  provisioner "local-exec" {
    command = "cat > avi.yml <<EOL\n${data.template_file.avi_yaml_values_static_cluster[count.index].rendered}\nEOL"
  }
}

data "template_file" "avi_yaml_values_static_standalone" {
  template = file("templates/avi_yaml_values.yml.template")
  count            = var.dhcp == false && var.avi.config.cluster == false ? 1 : 0
  vars = {
    controller_ips = jsonencode(vsphere_virtual_machine.controller_static_standalone.*.default_ip_address)
    controller_ntp = jsonencode(var.controller.ntp)
    controller_dns = jsonencode(var.controller.dns)
    cluster = jsonencode(var.avi.config.cluster)
    avi_password = var.avi_password
    avi_old_password = var.avi_old_password
    avi_version = var.avi.config.version
    avi_username = var.avi.config.username
    vsphere_username = var.vsphere_username
    vsphere_password = var.vsphere_password
    vsphere_server = var.vsphere_server
    domains = jsonencode(var.avi.config.vcenter.domains)
    cloud_name = var.avi.config.vcenter.cloud.name
    dc = var.vcenter_dc
    dchp_enabled = jsonencode(var.avi.config.vcenter.cloud.dhcp_enabled)
    network_management = jsonencode(var.avi.config.vcenter.cloud.network_management)
    network_vip = jsonencode(var.avi.config.vcenter.cloud.network_vip)
    network_backend = jsonencode(var.avi.config.vcenter.cloud.network_backend)
    service_engine_groups = jsonencode(var.avi.config.vcenter.cloud.service_engine_groups)
    pools = jsonencode(var.avi.config.vcenter.cloud.pools)
    pool_groups = jsonencode(var.avi.config.vcenter.cloud.pool_groups)
    virtual_services = jsonencode(var.avi.config.vcenter.cloud.virtual_services)
  }
}

resource "null_resource" "dump_locally_avi_yaml_values_static_standalone" {
  count            = var.dhcp == false && var.avi.config.cluster == false ? 1 : 0
  provisioner "local-exec" {
    command = "cat > avi.yml <<EOL\n${data.template_file.avi_yaml_values_static_standalone[count.index].rendered}\nEOL"
  }
}

resource "null_resource" "avi_ansible" {
  depends_on = [null_resource.dump_locally_avi_yaml_values_dhcp_cluster, null_resource.dump_locally_avi_yaml_values_dhcp_standalone, null_resource.dump_locally_avi_yaml_values_static_cluster, null_resource.dump_locally_avi_yaml_values_static_standalone, null_resource.wait_https_controller_dhcp_cluster, null_resource.wait_https_controller_dhcp_standalone, null_resource.wait_https_controller_static_standalone, null_resource.wait_https_controller_static_cluster]
  provisioner "local-exec" {
    command = "git clone ${var.ansible.aviPbAbsentUrl} --branch ${var.ansible.aviPbAbsentTag} ; git clone ${var.ansible.aviConfigureUrl} --branch ${var.ansible.aviConfigureTag}; cd ${split("/", var.ansible.aviConfigureUrl)[4]} ; ansible-playbook vcenter.yml --extra-vars @../avi.yml --extra-vars '{\"vcenter_folder\": \"${var.vcenter_folder}${random_string.id.result}\"}'"
  }
}

