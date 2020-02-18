output "virtual_machine_names" {

  description = "VM Name."

  value = ["${flatten(list(

 #   vsphere_virtual_machine.vm_linux.*.name,

    vsphere_virtual_machine.vm_windows.*.name,

  ))}"]

}



output "virtual_machine_ids" {

  description = "VM ID, indexed by name."



  value = "${zipmap(

    flatten(list(

   #   vsphere_virtual_machine.vm_linux.*.name,

      vsphere_virtual_machine.vm_windows.*.name,

    )),

    flatten(list(

 #     vsphere_virtual_machine.vm_linux.*.id,

      vsphere_virtual_machine.vm_windows.*.id,

    )),

  )}"

}



output "virtual_machine_default_ips" {

  description = "IP Address, indexed by name."



  value = "${zipmap(

    flatten(list(

#      vsphere_virtual_machine.vm_linux.*.name,

      vsphere_virtual_machine.vm_windows.*.name,

    )),

    flatten(list(

 #     vsphere_virtual_machine.vm_linux.*.default_ip_address,

      vsphere_virtual_machine.vm_windows.*.default_ip_address,

    )),

  )}"

}
