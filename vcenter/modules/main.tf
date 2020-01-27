# Luis Antonio Soares da Silva (lui_eu@msn.com / luissoares@outlook.com )


variable "vsphere_user" { type = string}
variable "vsphere_password" { type = string }
variable "vsphere_server" { type = string }
variable "name" { type = string }
variable "ipaddr" { type = string }
variable "cidr" { type = string }
variable "gateway" { type = string }
variable "dns_suffixes" { type = string }
variable "vcpu" { type = string }
variable "memory" { type = string }
variable "dswitchid" { type = string }
variable "vlanname" { type = string }
variable "vlanid" { type = string }
variable "datacenter" { type = string }
variable "datastore" { type = string }
variable "vm_template" { type = string }
variable "ostype" {
  description = "define os value linux/windows/appliance"
  default = {
      "windows"      = "windowssrv"
 #     "linux"        = "linuxsrv"
 #     "appliance"    = "appliancesrv"
  }
}
variable "vmcluster" { type = string }
variable "firmware" { type = string }
variable "resourcepoolname" { type = string }
# variable "environment" { type = "string" }
# variable "count" { type = "string" }
# variable "folder" { type = string }
# variable "role" { type = string }
# variable "dns_domain" { type = string }
# variable "dns_servers" { type = string }



provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "datacenter" {
  name = var.datacenter
}

data "vsphere_distributed_virtual_switch" "dswitchlan" { # DISTRIBUTED VSWITCH
  name          = var.dswitchid
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

 resource "vsphere_distributed_port_group" "vlan" { # VLAN PORT GROUP
  name                            = var.vlanname
  distributed_virtual_switch_uuid = data.vsphere_distributed_virtual_switch.dswitchlan.id
  active_uplinks  = [data.vsphere_distributed_virtual_switch.dswitchlan.uplinks[0]]
  standby_uplinks = [data.vsphere_distributed_virtual_switch.dswitchlan.uplinks[1]]
  vlan_id = var.vlanid
}


 
# ENV CODE
data "vsphere_datacenter" "dc" {
  name = var.datacenter #VCENTER DATACENTER NAME
}

data "vsphere_datastore" "defaultdatastore" {
  name          = var.datastore #DATASTORE NAME
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "vcentercluster" {
  name          = var.vmcluster #CLUSTERNAME
  datacenter_id = data.vsphere_datacenter.dc.id
}


#VM DEFINITION

/* data "vsphere_network" "vlan" {
  name          = var.vlanname #VLAN PORT GROUP
  datacenter_id = data.vsphere_datacenter.dc.id
} 
*/


data "vsphere_virtual_machine" "template" {
  name          = var.vm_template # TEMPLATE NAME
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "resourcepool" {
  name          = var.resourcepoolname # RESOURCE POOL NAME, CAN BE USED NAMES LIKE "SAOPAULO/LUREN"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vmname" {
  name             = var.name #VMNAME
  resource_pool_id = data.vsphere_compute_cluster.vcentercluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.defaultdatastore.id

  num_cpus = var.vcpu #vCPU
  memory   = var.memory #MEMORY
  firmware = var.firmware #Se der erro remover, nao utilizar password com 2 W
  guest_id = data.vsphere_virtual_machine.template.guest_id

  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id   = vsphere_distributed_port_group.vlan.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "Disk0" 
    size             = data.vsphere_virtual_machine.template.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id




# OS Configuration
/*
      customize {
      windows_options {
        computer_name = var.name
        network_interface {
          ipv4_address = var.ipaddr
          ipv4_netmask = var.cidr
          domain_admin_password = var.localpasswd
        }
        ipv4_gateway = var.gateway

     #   join_domain = var.domainjoin_name
     #   domain_admin_user = var.domainjoin_admin_user
     #   domain_admin_password = var.domainjoin_admin_password
        # organization_name = "Test"
      }
    timeout = 10
    network_interface {
    }
 }


 /*  
    customize {
      linux_options {
      host_name = var.name
      # domain    = "test.internal"
    }

      network_interface {
        ipv4_address = var.ipaddr
        ipv4_netmask = var.cidr
      }

      ipv4_gateway = var.gateway
    } */
  } 
 
}


# ANTI-AFINITY CONFIG
/* 
  resource "vsphere_compute_cluster_vm_anti_affinity_rule" "cluster_vm_anti_affinity_rule" {
  name                = "terraform-test-cluster-vm-anti-affinity-rule"
  compute_cluster_id  = "${data.vsphere_compute_cluster.cluster.id}"
  virtual_machine_ids = ["${vsphere_virtual_machine.vm.*.id}"]
} */
