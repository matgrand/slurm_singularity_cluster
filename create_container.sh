#!/bin/sh

# run this script to create a Singularity container on Ubuntu

#remove the existing container
rm -f test_container.sif

# build the container (sandbox -> to make modifications to the container later)
apptainer build --sandbox test_container.sif ubu20.def 

# let's enter the container (writable -> to make mods, cleanenv -> to avoid conflicts with the host
# environment, fakeroot -> to have root access inside the container)
apptainer shell --writable --cleanenv --fakeroot test_container.sif