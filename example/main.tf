#Luis Antonio Soares da Silva
module "vcenteradm" {
  vsphere_user = "terraform@vsphere.hmg"
  vsphere_password = "terraformuser_password"
  vsphere_server = "172.16.40.100"
  source = "../modules/vmware"
  datacenter = "EXAMPLE-DATACENTER"
  datastore = "DS01"
  vmcluster = "CL_SHARED_LAB"
  name = "vmteste01"
  ipaddr = "10.1.1.10"
  cidr = "24"
  vm_template = "Win2016-Template"
  vcpu = "4"
  memory = "8192" #MB
  firmware = "efi" #EFI / BIOS
  resourcepoolname = "HMG" #resourcepool  
  dswitchid = "DSwitchLAN"
  vlanname = "HMG-VLAN100" #Portgroupvlan
  vlanid = "100"
  gateway = "10.1.1.1"
  dns_suffixes = LUREN.LOCAL"
  }




