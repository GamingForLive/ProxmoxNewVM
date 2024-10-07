# ProxmoxNewVM
This Repository is meant to help those new to Proxmox to easily setup a VM With Cloud-Init

## Dependencies
> wget <br>
> qemu-img


## Variables
#### These are some variables that you can change:
`VMID=9999` > The ID of the vm that will be created <br> 
`VMNAME="debian-12-cloudinit"` > The name of the VM That will be created<br>
`MEMORY=2048` > How much memmory will be allocated to the VM By default <br>
`CORES=2` > How many cores the VM will be allocated by default <br>
`STORAGE="NVME"` > The Name of your Storage in proxmox <br>
`CLOUD_IMG_PATH="/var/lib/vz/template/qcow2/debian-12-generic-amd64.qcow2"`> The path where the Downloaded Cloud Image will be stored under <br>
`CLOUD_IMG_URL="https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2"` > The Path from which the Cloud image will be pulled by default Debian 12
`BRIDGE="vmbr0"` > The Network adapter that will be used by Default for the VM
