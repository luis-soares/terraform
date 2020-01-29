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

