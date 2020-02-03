provider "vsphere" {
  allow_unverified_ssl = true
}

/* module "vmnetwork" {
  source = "../modules/vmware/network"
  
  #VCENTER DATA
  vsphere_user = "terraformuser@vsphere.local"
  vsphere_password = "terraformpassword"
  vsphere_server = "10.10.0.50"
  
  #ENV DATA
  datacenter = "DC-TEST" # VSPHERE DATACENTER
  vmcluster = "Cloud-Cluster"      # VSPHERE CLUSTER
  
  #NETWORK 
  dswitchid = "DSwitch-LAN"          # Distributed Switch
  vlanname = "VLAN1001"                   # Portgroupvlan
  vlanid = "1001"                    # VLAN ID
}
 */

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
  
