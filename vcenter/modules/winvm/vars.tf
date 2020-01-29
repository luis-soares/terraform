

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
variable "disksize" { type = string}
variable "dswitchid" { type = string }
variable "vlanname" { type = string }
variable "vlanid" { type = string }
variable "datacenter" { type = string }
variable "datastore" { type = string }
variable "vm_template" { type = string }
variable "vmcluster" { type = string }
variable "firmware" { type = string }
variable "resourcepoolname" { type = string }
