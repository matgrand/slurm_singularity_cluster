#!/bin/sh

# run this script to create a Ubuntu x86 VM on M1 Mac
# tu run script open a terminal in the repo direectory and run:
# sh create_ubuntu_vm_m1_x86.sh


# install qemu and lima (https://lima-vm.io/)
brew install qemu lima

#delete the previous vm 
limactl stop lima_apptainer
limactl delete lima_apptainer

# start lima

#fast
# limactl start \
#     --name=lima_apptainer \
#     --cpus=6 \
#     --memory=6 \
#     --disk=50 \
#     --vm-type=vz \
#     --rosetta \
#     --tty=False \
#     --network=vzNAT \
#     template://apptainer-rootful \
#     --mount-writable \
#     # --mount $PWD:/singularity \

# #slow
limactl start \
    --name=lima_apptainer \
    --cpus=6 \
    --memory=6 \
    --disk=50 \
    --tty=False \
    --arch=x86_64 \
    --mount-writable \
    template://apptainer


# explanation of the above command: 
# --name lima_apptainer: name of the VM 
# --cpus 4: number of CPUs
# --memory 4: memory in GB
# --disk 50: disk size in GB
# --tty: disable interactive user interface
# --mount $PWD:/singularity: mount the current directory to the VM
# --mount-writable: mount the directory in writable mode
# --vm-type=qemu: use qemu
# --arch=x86_64: architecture is x86_64, not arm64, bc we are on arm64 M1 Mac and we want to create a x86 container

# log into the VM
limactl shell lima_apptainer