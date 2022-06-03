resource "vsphere_virtual_machine" "controller_dhcp_cluster" {
  count            = var.dhcp == true && var.avi.config.cluster == true ? 3 : 0
  name             = "controller-${count.index}"
  datastore_id     = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  folder           = vsphere_folder.folder.path
  network_interface {
    network_id = data.vsphere_network.network_mgmt.id
  }

  num_cpus = var.controller.cpu
  memory = var.controller.memory
  guest_id = "guestid-controller-${count.index}"

  disk {
    size             = var.controller.disk
    label            = "controller--${count.index}.lab_vmdk"
    thin_provisioned = true
  }

  clone {
    template_uuid = vsphere_content_library_item.file_avi.id
  }
}

resource "vsphere_virtual_machine" "controller_dhcp_standalone" {
  count            = var.dhcp == true && var.avi.config.cluster== false ? 1 : 0
  name             = "controller-${count.index}"
  datastore_id     = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  folder           = vsphere_folder.folder.path
  network_interface {
    network_id = data.vsphere_network.network_mgmt.id
  }

  num_cpus = var.controller.cpu
  memory = var.controller.memory
  guest_id = "guestid-controller-${count.index}"

  disk {
    size             = var.controller.disk
    label            = "controller--${count.index}.lab_vmdk"
    thin_provisioned = true
  }

  clone {
    template_uuid = vsphere_content_library_item.file_avi.id
  }
}

resource "vsphere_virtual_machine" "controller_static_cluster" {
  count            = var.dhcp == false && var.avi.config.cluster== true ? 3 : 0
  name             = "controller-${count.index}"
  datastore_id     = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  folder           = vsphere_folder.folder.path
  network_interface {
    network_id = data.vsphere_network.network_mgmt.id
  }

  num_cpus = var.controller.cpu
  memory = var.controller.memory
  guest_id = "guestid-controller-${count.index}"

  disk {
    size             = var.controller.disk
    label            = "controller--${count.index}.lab_vmdk"
    thin_provisioned = true
  }

  clone {
    template_uuid = vsphere_content_library_item.file_avi.id
  }

  vapp {
    properties = {
      "mgmt-ip"     = var.avi_ip4_addresses[count.index]
      "mgmt-mask"   = var.network_mask
      "default-gw"  = var.gateway4
    }
  }
}

resource "vsphere_virtual_machine" "controller_static_standalone" {
  count            = var.dhcp == false && var.avi.config.cluster== false ? 1 : 0
  name             = "controller-${count.index}"
  datastore_id     = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  folder           = vsphere_folder.folder.path
  network_interface {
    network_id = data.vsphere_network.network_mgmt.id
  }

  num_cpus = var.controller.cpu
  memory = var.controller.memory
  guest_id = "guestid-controller-${count.index}"

  disk {
    size             = var.controller.disk
    label            = "controller--${count.index}.lab_vmdk"
    thin_provisioned = true
  }

  clone {
    template_uuid = vsphere_content_library_item.file_avi.id
  }

  vapp {
    properties = {
      "mgmt-ip"     = var.avi_ip4_addresses[count.index]
      "mgmt-mask"   = var.network_mask
      "default-gw"  = var.gateway4
    }
  }
}

resource "null_resource" "wait_https_controller_dhcp_cluster" {
  depends_on = [vsphere_virtual_machine.controller_dhcp_cluster]
  count            = var.dhcp == true && var.avi.config.cluster== true ? 3 : 0

  provisioner "local-exec" {
    command = "until $(curl --output /dev/null --silent --head -k https://${vsphere_virtual_machine.controller_dhcp_cluster[count.index].default_ip_address}); do echo 'Waiting for Avi Controllers to be ready'; sleep 10 ; done"
  }
}

resource "null_resource" "wait_https_controller_dhcp_standalone" {
  depends_on = [vsphere_virtual_machine.controller_dhcp_standalone]
  count            = var.dhcp == true && var.avi.config.cluster== false ? 1 : 0

  provisioner "local-exec" {
    command = "until $(curl --output /dev/null --silent --head -k https://${vsphere_virtual_machine.controller_dhcp_standalone[count.index].default_ip_address}); do echo 'Waiting for Avi Controllers to be ready'; sleep 10 ; done"
  }
}

resource "null_resource" "wait_https_controller_static_cluster" {
  depends_on = [vsphere_virtual_machine.controller_static_cluster]
  count            = var.dhcp == false && var.avi.config.cluster== true ? 1 : 0

  provisioner "local-exec" {
    command = "until $(curl --output /dev/null --silent --head -k https://${vsphere_virtual_machine.controller_static_cluster[count.index].default_ip_address}); do echo 'Waiting for Avi Controllers to be ready'; sleep 10 ; done"
  }
}

resource "null_resource" "wait_https_controller_static_standalone" {
  depends_on = [vsphere_virtual_machine.controller_dhcp_standalone]
  count            = var.dhcp == false && var.avi.config.cluster== false ? 1 : 0

  provisioner "local-exec" {
    command = "until $(curl --output /dev/null --silent --head -k https://${vsphere_virtual_machine.controller_static_standalone[count.index].default_ip_address}); do echo 'Waiting for Avi Controllers to be ready'; sleep 10 ; done"
  }
}