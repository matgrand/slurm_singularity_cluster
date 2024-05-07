#!/bin/sh

# now we are in ubuntu
# run this script to create a Singularity container on Ubuntu
# (following https://apptainer.org/docs/admin/main/installation.html)
# tu run script open a terminal in the repo direectory and run
# sh singularity/create_singularity_container.sh

# update the system
sudo apt update -y && sudo apt upgrade -y

# install singularity
sudo apt install -y software-properties-common
sudo add-apt-repository -y ppa:apptainer/ppa
sudo apt update -y
sudo apt install -y apptainer
# sudo apt install -y apptainer-suid 

# check the singularity version
singularity --version
