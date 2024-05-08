#!/bin/sh

# now we are in ubuntu
# run this script to create a Singularity container on Ubuntu
# (following https://apptainer.org/docs/admin/main/installation.html)
# tu run script open a terminal in the repo direectory and run
# sh singularity/create_singularity_container.sh

# update the system
apt update -y && apt upgrade -y

# install singularity
apt install -y software-properties-common
add-apt-repository -y ppa:apptainer/ppa
apt update -y
# apt install -y apptainer
apt install -y apptainer-suid 

# check the singularity version
singularity --version
