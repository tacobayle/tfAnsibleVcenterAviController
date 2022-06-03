#
# Environment Variables
#
variable "vsphere_username" {}
variable "vsphere_password" {}
variable "avi_password" {}
variable "avi_backup_passphrase" {}
variable "avi_old_password" {}
variable "avi_controller_url" {}
#
# other variables
#
variable "vsphere_server" {
  default = "wdc-06-vc12.oc.vmware.com"
}

variable "vcenter_dc" {
  default = "wdc-06-vc12"
}

variable "vcenter_cluster" {
  default = "wdc-06-vc12c01"
}

variable "vcenter_datastore" {
  default = "wdc-06-vc12c01-vsan"
}

variable "vcenter_network_mgmt_name" {
  default = "vxw-dvs-34-virtualwire-3-sid-6120002-wdc-06-vc12-avi-mgmt"
}

variable "avi_ip4_addresses" {
  default = ["10.206.112.76", "10.206.112.77", "10.206.112.113"]
}

variable "network_mask" {
  default = "255.255.253.0"
}

variable "gateway4" {
  default = "10.206.112.1"
}

variable "dhcp" {
  default = true
}

variable "content_library" {
  default = {
    basename = "content_library_tf_"
  }
}

variable "vcenter_folder" {
  default = "tf_avi_demo_"
}

variable "controller" {
  default = {
    cpu = 8
    name = "avi-controller"
    memory = 24768
    disk = 128
    dns =  ["10.206.8.130", "10.206.8.131"]
    ntp = ["95.81.173.155", "188.165.236.162"]
  }
}

variable "avi" {}

variable "ansible" {
  default = {
    aviPbAbsentUrl = "https://github.com/tacobayle/ansibleAviClear"
    aviPbAbsentTag = "v1.03"
    aviConfigureTag = "v1.48"
    aviConfigureUrl = "https://github.com/tacobayle/ansibleAviConfig"
  }
}