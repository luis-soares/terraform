# Luis Antonio Soares da Silva (luissoares@outlook.com / lui_eu@msn.com )

provider "vsphere" {
  #Can also be specified with the VSPHERE_USER environment variable.
  #user           = var.vsphere_user

  #Can also be specified with the VSPHERE_PASSWORD environment variable
  #password       = var.vsphere_password

  #Can also be specified with the VSPHERE_SERVER environment variable.
  vsphere_server = var.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

# https://www.terraform.io/docs/providers/vsphere/index.html#user

