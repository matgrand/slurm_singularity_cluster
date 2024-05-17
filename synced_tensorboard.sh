#!/bin/bash

# This script will sync the logs from the cluster to the local machine
# The logs will be stored in the tmp/ directory

# Define the user, source and destination, change accordingly
usr="grandinmat"
src="/home/$usr/repos/mpc_tests/lightning_logs/"
dst="$HOME/tmp/lightning_logs/"

# kill any running tensorboard
pkill -f tensorboard

# start tensorboard on the local machine
tensorboard --logdir $dst --port 6006 &

# Sync the logs every x seconds
while true; do
    echo "Syncing logs between $usr and $dst"
    rsync -r $usr@login.dei.unipd.it:$src $dst 
    sleep 10
done
