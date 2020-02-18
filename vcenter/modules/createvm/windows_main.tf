# Luis Antonio Soares da Silva (lui_eu@msn.com / luissoares@outlook.com) 

# REMOVE SYSPREP FROM TEMPLATE, IF YOU DONT REMOVE... THE ERROR WILL BE SHOWED:
# Virtual machine customization failed on 

# We are using module depends_on 'cause we need to wait a vlan creation.

provider "vsphere" {
/*   user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server */
  # If you have a self-signed cert
  allow_unverified_ssl = true
}

resource "vsphere_virtual_machine" "vm_windows" {
  count            = var.template_os_family == "windows" ? var.vm_count : 0

  name             = "${var.vm_name_prefix}${count.index+1}"
  resource_pool_id = data.vsphere_resource_pool.resourcepool.id
  
  datastore_id     = data.vsphere_datastore.defaultdatastore.id

  num_cpus = var.num_cpus           #vCPU
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
    size             = var.disk_size != "" ? var.disk_size : data.vsphere_virtual_machine.template[count.index]
  #  size             = var.disk_size != "" ? var.disk_size : data.vsphere_virtual_machine.template.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

   clone {
    template_uuid = data.vsphere_virtual_machine.template.id
  
    customize {
      windows_options {
      computer_name   = "${var.vm_name_prefix}${count.index+1}"
      }
      network_interface {
        ipv4_address    = var.ipv4_network_address != "0.0.0.0/0" ? cidrhost(var.ipv4_network_address, var.ipv4_address_start + count.index) : ""
        ipv4_netmask    = var.ipv4_network_address != "0.0.0.0/0" ? element(split("/", var.ipv4_network_address), 1) : 0    
        #   domain_admin_password = var.localpasswd               # PASSWD
      } # END NETWORK INTERFACE
      ipv4_gateway = var.ipv4_gateway 
      dns_server_list = var.dnslist                             #IP GATEWAY
       
    } # ENDS CUSTOMIZE
  } # END CLONE
}
  
