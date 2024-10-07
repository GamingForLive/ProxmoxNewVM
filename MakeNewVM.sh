#!/bin/bash

#########################################
#   Script by Jan with help of OpenAI   #
#########################################

# Variables
VMID=9999
VMNAME="debian-12-cloudinit"
MEMORY=2048
CORES=2
STORAGE="NVME"
CLOUD_IMG_URL="https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2"
CLOUD_IMG_PATH="/var/lib/vz/template/qcow2/debian-12-generic-amd64.qcow2"
VM_DISK_NAME="debian-12-6-cloudinit"
BRIDGE="vmbr0"

#Downloading the Debian image
echo "Downloading Debian 12 cloud image..."
if [ ! -f "$CLOUD_IMG_PATH" ]; then
    wget -O "$CLOUD_IMG_PATH" "$CLOUD_IMG_URL"
else
    echo "Debian cloud image already exists at $CLOUD_IMG_PATH"
fi

#Creating the VM
echo "Creating VM with ID $VMID..."
qm create $VMID --name "$VMNAME" --memory $MEMORY --cores $CORES --net0 virtio,bridge=$BRIDGE

#Formating the downloaded disk to make shure its in the right format
qemu-img convert -f raw -O qcow2 debian-12-generic-amd64.qcow2 $VM_DISK_NAME

#Import downloaded disk into the VM
echo "Importing disk to VM..."
qm importdisk $VMID $VM_DISK_NAME $STORAGE --format qcow2

#Attach the imported disk to the VM
echo "Attaching disk to VM..."
qm set $VMID --scsihw virtio-scsi-pci --scsi0 "$STORAGE:$VMID/vm-$VMID-disk-0.qcow2"

#Add Cloud-Init disk
echo "Adding Cloud-Init disk..."
qm set $VMID --ide2 "$STORAGE:cloudinit"

#Configure boot order
echo "Configuring boot order..."
qm set $VMID --boot c --bootdisk scsi0

#Set serial console for Cloud-Init
echo "Configuring serial console..."
qm set $VMID --serial0 socket --vga serial0

#Configuring Cloud-Init network
echo "Configuring Cloud-Init network (DHCP)..."
qm set $VMID --ipconfig0 ip=dhcp

echo "VM $VMID created Please verify the Settings manually."
