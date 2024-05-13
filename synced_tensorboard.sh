#!/bin/bash

# This script will sync the logs from the cluster to the local machine
# The logs will be stored in the tmp/ directory

usr="grandinmat"
src="/home/$usr/repos/mpc_tests/lightning_logs/"
dst="tmp/lightning_logs/"

# start tensorboard on the local machine
tensorboard --logdir $dst --port 6006 &

# Sync the logs every 2 seconds
while true; do
    rsync -r $usr@login.dei.unipd.it:$src $dst
    sleep 2
done

