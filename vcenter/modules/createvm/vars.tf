# Luis Antonio Soares da Silva (lui_eu@msn.com / luissoares@outlook.com) 

# VCENTER VARS
/* variable "vsphere_user" { type = string}
variable "vsphere_password" { type = string }
variable "vsphere_server" { type = string } */

# ENV VCENTER
variable "datacenter" {
  type = string 
  description = "vmware datacenter"
  default = "DC-LUREN"
}

variable "vmcluster" {
  type = string
  description = "VCENTER Cluster Name"
  default = "Cloud-LUREN"
}

variable "resourcepoolname" {
  type = string
  description = "Resource Pool to deploy VMs. EX: Cluster_Name/Resources/RESOURCE_POOL/RESOURCE_POOL2 "
  default = "Cloud-LUREN/Resources/DEFAULT_TERRAFORM_DEPLOY"  
}

# ==========================



# NETWORK VARS

variable "dswitchid" {
  type = string 
  description = "Distributed vSwitch name."
  default = "DSwitch-LAN"
}

variable "network" {
  type = string
  description = "Name of VLAN from Distributed Switch"
}

variable "vlanid" {
  type = string
  description = "Number of VLAN ID."
  default = "0" 
}

# OS NETWORK VARS

variable "ipv4_network_address" { 
  type = string 
  description = "IPv4 Address, to use DHCP leave it at blank. To set, use: A.B.C.D/XX CIDR."
  default = "0.0.0.0/0"  
}

variable "ipv4_address_start" {
  type = string
  description = "Start number of IPs. Ex: If starts with 10, will be deployed: A.B.C.10/XX . "
  default = "15"  
}

variable "ipv4_gateway" { 
  type = string
  description = "IPv4 Gateway. To use DHCP, leave blank." 
  default = "" 
}

variable "dns_suffixes" {
  type = string
  description = "DNS Machine Sufixes."
  default = "LUREN-CLOUD.LOCAL"
}

variable "dnslist" {   
  type = list(string)
  default = ["8.8.8.8", "1.1.1.1"] 
  description = "DNS List, leave at the default to use Public DNSs."
}

variable "workgroup" {
  type = string
  description = "VM Workgroup for windows."
  default = "MATRIX-CLOUD"
}


#OS VARS

variable "vm_name_prefix" {
  type        = string
  description = "The prefix to use for virtual machines created with this module."
}

variable "vm_count" {
  description = "The number of virtual machines to create."
  default     = "1"
}

variable "firmware" {
  description = "The number of virtual machines to create."
  default     = "bios"
}

variable "name" {
  description = "The number of virtual machines to create."
  default = "test"
}

variable "num_cpus" {
  type = string
  description = "Number of vCPU."
}

variable "memory" { 
  type = string
  description = "Memory in MB."  
}

variable "disk_size" {
  type = string
  description = "Disk size in GB."
}

variable "datastore" { 
  type = string
  description = "DataStore Name"
 }

variable "template_name" {
   type = string 
   description = "Template name."
   }

variable "template_os_family" {
  description = "The OS family. Should be Linux or Windows."
  default     = ""
}






