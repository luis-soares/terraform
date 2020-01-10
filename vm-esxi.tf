# Luis Antonio Soares da Silva (luissoares@outlook.com / lui_eu@msn.com )
# VCENTER Deploy
# Based on official documentation: https://www.terraform.io/docs/providers/vsphere/r/virtual_machine.html

data "vsphere_datacenter" "dc" {
  name = "LUREN-DC" #VCENTER DATACENTER NAME
}

data "vsphere_datastore" "datastore" {
  name          = "PURE-V01" #DATASTORE NAME
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = "PROD" #CLUSTERNAME
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "VLAN100-WAN" #VLAN PORT GROUP
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = "Template-WindowsServer2019_STD_03_01_20" # TEMPLATE NAME
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = "LUREN/WEBSITE" # RESOURCE POOL NAME, CAN BE USED NAMES LIKE "LUREN"
  datacenter_id = data.vsphere_datacenter.dc.id
}


resource "vsphere_virtual_machine" "vm" {
  name             = "windows-luis-terraform-test" #VMNAME
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = 2 #vCPU
  memory   = 2048 #MEMORY
  firmware = "efi" #EFI or BIOS, use the same of your template
  guest_id = data.vsphere_virtual_machine.template.guest_id

  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.network.id
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

# Try these options to customize your Windows or Linux Vm:
# customize {
#   windows_options {
#     computer_name = "${var.vsphere_vm_name}"
#     join_domain = "${var.domainjoin_name}"
#     domain_admin_user = "${var.domainjoin_admin_user}"
#     domain_admin_password = "${var.domainjoin_admin_password}"
#     organization_name = "Test"
#   }
#   #Ttime in minutes
#   timeout = 10
#   network_interface {
    
#   }
# }


#    customize {
    #   linux_options {
    #     host_name = "terraform-test"
    #     domain    = "test.internal"
    #   }

    #   network_interface {
    #     ipv4_address = "10.0.0.10"
    #     ipv4_netmask = 24
    #   }

    #   ipv4_gateway = "10.0.0.1"
    #}
  }
}

