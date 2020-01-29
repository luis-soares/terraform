# Luis Antonio Soares da Silva (luissoares@outlook.com / lui_eu@msn.com)


provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

# ====================================================================================================

# ENV CODE
data "vsphere_datacenter" "dc" {
  name = var.datacenter #VCENTER DATACENTER NAME
}

data "vsphere_compute_cluster" "vcentercluster" {
  name          = var.vmcluster #CLUSTERNAME
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_distributed_virtual_switch" "dswitchlan" { # DISTRIBUTED VSWITCH
  name          = var.dswitchid
  datacenter_id = data.vsphere_datacenter.dc.id
}

# ====================================================================================================

# CRIA VLAN PORT GROUP
 resource "vsphere_distributed_port_group" "vlan" { # VLAN PORT GROUP
  name                            = var.vlanname
  distributed_virtual_switch_uuid = data.vsphere_distributed_virtual_switch.dswitchlan.id
#  active_uplinks  = [data.vsphere_distributed_virtual_switch.dswitchlan.uplinks[0]]
#  standby_uplinks = [data.vsphere_distributed_virtual_switch.dswitchlan.uplinks[1]]
  vlan_id = var.vlanid
}
