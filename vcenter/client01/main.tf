provider "vsphere" {
  allow_unverified_ssl = true
}

# ========================================

module "winvm" {
  source = "../modules/vmware/winvm"

  #VCENTER DATA
  vsphere_user = "terraformuser@vsphere.local"
  vsphere_password = "terraformpassword"
  vsphere_server = "10.10.0.50"
  
  #ENV DATA
  datacenter = "DC-TEST" # VSPHERE DATACENTER
  vmcluster = "Cloud-Cluster"      # VSPHERE CLUSTER
  resourcepoolname = "Cloud-Cluster/Resources/CLIENTES/GERENCIADOS/TESTE01"     # RESOURCE POOL
  datastore = "DS01"                # DATASTORE
 
  #NETWORK 
  dswitchid = "DSwitch-LAN"          # Distributed Switch
  vlanname = "VLAN1001"              # Portgroupvlan
  vlanid = "1001"                    # VLAN ID

  #VM HW
  name = "SRV01"                # HOSTNAME/VMNAME
  vcpu = "4"                        # vCPU
  memory = "8192"                   # MB
  disksize = "400"                   # GB
  firmware = "efi"                  # EFI / BIOS

  #VM CONFIG
  vm_template = "Template-TP-Win2019-Terraform"  # TEMPLATE NAME
  ipaddr = "172.16.0.22"          # IP ADDRESS
  cidr = "26"                       # CIDR MASK
  gateway = "172.16.0.1"         # GATEWAY
  dns_suffixes = "WorkGroup" # DOMAIN NAME
  dnslist = ["8.8.8.8", "1.1.1.1"]
  }
