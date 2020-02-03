# Luis Antonio Soares da Silva (lui_eu@msn.com / luissoares@outlook.com) 

# VCENTER VARS
variable "vsphere_user" { type = string}
variable "vsphere_password" { type = string }
variable "vsphere_server" { type = string }

# ENV VCENTER
variable "datacenter" { type = string }
variable "vmcluster" { type = string }

# NETWORK VARS
variable "dswitchid" { type = string }
variable "vlanname" { type = string }
variable "vlanid" { type = string }

#OS VARS

variable "name" { type = string }
variable "ipaddr" { type = string }
variable "cidr" { type = string }
variable "gateway" { type = string }
variable "dns_suffixes" { type = string }
variable "vcpu" { type = string }
variable "memory" { type = string }
variable "disksize" { type = string}
variable "datastore" { type = string }
variable "vm_template" { type = string }
variable "firmware" { type = string }
variable "resourcepoolname" { type = string }





