#!/bin/sh

# reset the VM
multipass stop ubu22
multipass delete ubu22
multipass purge
multipass list
echo "VM reset done, you should not see any ubu22 VM in the list above"

#delete the container
rm -rf test_container.sif