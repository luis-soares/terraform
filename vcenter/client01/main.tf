variable "vsphere_server" {
  default = "172.16.0.50"
}

variable "datacenter" {
  default = "DC-LUREN-BR" # VSPHERE DATACENTER
}

variable "vmcluster" {
  default = "Cloud-LUREN"      # VSPHERE CLUSTER
}

variable "datastore" {
  default = "Pure-V10" 
}

variable "network" {
  default =  "VLAN1000-LUREN"                 # Portgroupvlan
}



variable "resourcepoolname" {
  default = "Cloud-Matrix/Resources/LUREN"
}

variable "dswitchid" {
  default = "DSwitch-LAN"
}

variable "vlanid" {
  default = "1000"
}



#ENV DATA


module "virtual_machines" {
  source               = "../modules/vmware/createvm/"
#  admin_password       = "TestP@ssw0rdLuis"
  num_cpus                 = "4"        #vCPU
  memory               = "4096"         #MEMORY
  disk_size             = "80"
#  guest_id = data.vsphere_virtual_machine.template.guest_id
  ipv4_address_start   = "200"
  ipv4_gateway         = "192.168.254.1"
  ipv4_network_address = "192.168.254.0/24"
#  linked_clone         = "${var.linked_clone}"
  template_name        = "TP-Win2019-Template-Terraform"
  template_os_family   = "windows"
  vm_count             = "5"
  vm_name_prefix       = "srvtesteluis0"
  workgroup            = "testeworkgroup"
  firmware             = "efi"        #EFI / BIOS
  datastore            = var.datastore
#  vlanname             = var.vlanname
  network              = var.network
  datacenter           = var.datacenter
  resourcepoolname        = var.resourcepoolname
}

