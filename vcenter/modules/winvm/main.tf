# Luis Antonio Soares da Silva (lui_eu@msn.com / luissoares@outlook.com) 

# REMOVE SYSPREP FROM TEMPLATE, IF YOU DONT REMOVE... THE ERROR WILL BE SHOWED:
# Virtual machine customization failed on 

# We are using module depends_on 'cause we need to wait a vlan creation.

provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

# ===============================================================================================================
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


data "vsphere_distributed_virtual_switch" "dswitchlan" { # DISTRIBUTED VSWITCH
  name          = var.dswitchid
  datacenter_id = data.vsphere_datacenter.dc.id
}

# ===============================================================================================================
#VM DEFINITION

  data "vsphere_network" "vlan" {
  depends_on = [var.vm_depends_on]
  name          = var.vlanname #VLAN PORT GROUP
  datacenter_id = data.vsphere_datacenter.dc.id
} 



data "vsphere_virtual_machine" "template" {
  name          = var.vm_template # TEMPLATE NAME
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "resourcepool" {
  name          = var.resourcepoolname # RESOURCE POOL NAME, CAN BE USED NAMES LIKE "SAOPAULO/LUREN"
  datacenter_id = data.vsphere_datacenter.dc.id
}


# ===============================================================================================================
# CREATE VM 

#TIRAR O SYSPREP

resource "vsphere_virtual_machine" "vmname" {

  name             = var.name   #VMNAME
  resource_pool_id = data.vsphere_compute_cluster.vcentercluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.defaultdatastore.id

  num_cpus = var.vcpu           #vCPU
  memory   = var.memory         #MEMORY
  firmware = var.firmware       #EFI / BIOS
  guest_id = data.vsphere_virtual_machine.template.guest_id

  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.vlan.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "Disk0"  
    size             = var.disksize
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

   clone {
    template_uuid = data.vsphere_virtual_machine.template.id

  
    customize {
      windows_options {
        computer_name = var.name                                # HOSTNAME
      }
      network_interface {
        ipv4_address = var.ipaddr                             # IP ADDRESS
        ipv4_netmask = var.cidr                               # MASK
     #   domain_admin_password = var.localpasswd               # PASSWD
      } # END NETWORK INTERFACE
      ipv4_gateway = var.gateway                              #IP GATEWAY
       
    } # ENDS CUSTOMIZE
  } # END CLONE
}
  
