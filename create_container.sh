#!/bin/sh

# run this script to create a Singularity container on Ubuntu

sudo rm -rf test_container.sif

# build the container (sandbox -> to make modifications to the container later)
# apptainer build --sandbox test_container.sif pt.def 
# apptainer build --sandbox test_container.sif numpy.def 
sudo apptainer build test_container.sif amd64_ubu.def 
# apptainer build --sandbox test_container.sif ubu20.def 
# apptainer build --sandbox test_container.sif ubu22.def 

echo "Container built"

# let's enter the container (writable -> to make mods, cleanenv -> to avoid conflicts with the host
# environment, fakeroot -> to have root access inside the container)
sudo apptainer shell --writable --cleanenv --fakeroot test_container.sif