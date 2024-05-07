#!/bin/sh

# run this script to create a Ubuntu VM on M1 Mac
# tu run script open a terminal in the repo direectory and run:
# sh create_ubuntu_vm_m1.sh

clear 
echo "This script will create a Ubuntu VM on M1 Mac"

# install multipass, requires brew (https://brew.sh/)
brew install multipass

# run multipass to create a VM  (version:22.04, name:ubu22, cpu:4, memory:4G, disk:50G)
multipass launch 22.04 -n ubu22 -c 4 -m 4G -d 50G

# show the VM list
multipass list

# mount the current directory to the VM
CURR_DIR=$(pwd)
echo "Current directory is: $CURR_DIR"
multipass mount $CURR_DIR ubu22:singularity

# log into the VM
multipass shell ubu22

