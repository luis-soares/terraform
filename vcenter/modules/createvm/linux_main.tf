# Luis Antonio Soares da Silva (lui_eu@msn.com / luissoares@outlook.com) 

# Virtual machine customization failed on (Maybe is necessary install perl)

# ===============================================================================================================
# CREATE VM 


resource "vsphere_virtual_machine" "vmname" {
 
  count            = var.template_os_family == "linux" ? var.vm_count : 0
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
    size             = var.disk_size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

   clone {
    template_uuid = data.vsphere_virtual_machine.template.id

  
    customize {
      linux_options {
        host_name = "${var.vm_name_prefix}${count.index+1}"            # HOSTNAME
        domain = var.dns_suffixes
      }
      network_interface {
        ipv4_address    = var.ipv4_network_address != "0.0.0.0/0" ? cidrhost(var.ipv4_network_address, var.ipv4_address_start + count.index) : "" # IP ADDRESS
        ipv4_netmask    = var.ipv4_network_address != "0.0.0.0/0" ? element(split("/", var.ipv4_network_address), 1) : 0     # MASK
        #   domain_admin_password = var.localpasswd               # PASSWD
      } # END NETWORK INTERFACE
      ipv4_gateway = var.ipv4_gateway                              #IP GATEWAY
      # dns_server_list = [var.dnslist]
    } # ENDS CUSTOMIZE
  } # END CLONE
}
  
