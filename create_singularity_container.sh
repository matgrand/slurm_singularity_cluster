#!/bin/sh

# now we into the VM, running ubuntu 
# run this script to create a Singularity container on Ubuntu VM
# tu run script open a terminal in the repo direectory and run:
# sh singularity/create_singularity_container.sh

# update the system
sudo apt update -y && sudo apt upgrade -y

# install singularity
sudo wget -O- http://neuro.debian.net/lists/xenial.us-ca.full | sudo tee /etc/apt/sources.list.d/neurodebian.sources.list && \
    sudo apt-key adv --recv-keys --keyserver hkp://pool.sks-keyservers.net:80 0xA5D32F012649A5A9 && \
    sudo apt-get update
sudo apt-get install -y singularity-container

# check the singularity version
singularity --version
