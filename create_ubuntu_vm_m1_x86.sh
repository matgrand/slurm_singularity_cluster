#!/bin/sh

# run this script to create a Ubuntu x86 VM on M1 Mac
# tu run script open a terminal in the repo direectory and run:
# sh create_ubuntu_vm_m1_x86.sh


# install qemu and lima (https://lima-vm.io/)
brew install qemu lima

#delete the previous vm 
limactl stop default
limactl delete default

# start arm64 vm with lima and rosetta
limactl start \
    --vm-type=vz \
    --rosetta \
    --tty=False \
    # --cpus=4 \
    # --memory=4 \
    # --disk=50 \

# writable folder in /tmp/lima

echo "Arm VM started, creating x86 container inside the VM"

#copy everything in the current directory to /tmp/lima
cp -r . /tmp/lima

# run a x86 container in the rosetta vm (-it -> interactive terminal, --rm -> remove container after exit)

lima nerdctl run -it --rm --platform=linux/amd64 -v /tmp/lima:/tmp/lima ubuntu:22.04 bash