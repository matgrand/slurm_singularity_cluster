# DEI Cluster: how to Slurm and Singularity containers for Python Machine Learning jobs

This document describes how to use Slurm and Singularity containers in the DEI cluster. For
additional information refer to the [DEI cluster
documentation](https://docs.dei.unipd.it/en/CLUSTER). 
Slurm is a job scheduler widely used in HPC (High Performance Compute) clusters. Singularity/Apptainer is a container system that allows
to run applications in a controllable and reproducible way.

This small guide will focus on running a python program in a Singularity container using Slurm,
using the pytorch framework as a notable example.

## High-level overview
The idea is to create a singularity container with the necessary dependencies (like pytorch, numpy, matplotlib, etc).
Then, we will use this container to run a python script in the cluster. The script will be submitted
to the Slurm scheduler.

## Step 1: Create the Singularity/Apptainer container
There are many ways to create a Singularity container, pls refer to the [Apptainer
documentation](https://apptainer.org/docs/user/main/index.html) and the [Singularity
documentation](https://docs.sylabs.io/guides/3.5/user-guide/index.html) for more information.

The easiest (and most compatible across os) way is to create the container on the cluster itself.

1. Connect to the DEI cluster using SSH. In a terminal, type:
    ```bash
    ssh <username>@login.dei.unipd.it
    ```
    and enter your password. 
    
    You should be in the login node `[<username>@login ~]$`. Typing `ls` should show your home directory.

2. Create an interactive session on a compute node by typing:
    ```bash
    interactive
    ```
    You should be in a compute node `<username>@runnersomething:~ $`.
    > Don't abuse interactive sessions, they are meant for testing and debugging. Not for running
    long jobs.

3. Clone this repository and `cd` into it:
    ```bash
    git clone https://github.com/matgrand/slurm_singularity_cluster
    cd slurm_singularity_cluster
    ```

4. Look and modify the `mydefinition.def` file to suit your needs (with `nano mydefinition.def` for example).
    The file contains the instructions to build the container. You can add more dependencies, change
    the base docker image, etc.
    
    `mydefinition.def`:
    ```bash
    Bootstrap: docker # Use the docker bootstrapper to load a docker image
    From: pytorch/pytorch # Use the pytorch/pytorch image as the base image

    %post # Optional: after the base image is installed run the following commands
        apt -y update # Update the package list
        pip install matplotlib # Install a python package

    %runscript #Optional: the command to run when the container is started
        python --version # Print the python version
        python -c "import torch; print(torch.__version__)" # Print the pytorch version
    ```
    The `mydefinition.def` file will create a singularity container based on the official pytorch docker
    image (for more base images refer to the [docker hub](https://hub.docker.com/)). It will install
    the `matplotlib` python package.
    It will also print the python and pytorch versions. 
    > If you already know all the necessary dependencies, you can put them in the `.def` file.
    > Otherwise, you can install them later by running commands in the container.

    > [Here](https://apptainer.org/docs/user/main/quick_start.html#building-images-from-scratch) you
    can find more information on how to create a container from scratch and what the `%post` and
    `%runscript` sections do.

5. Build the container:
    ```bash
    singularity build --sandbox mycontainer.sif mydefinition.def
    ```
    The `mycontainer.sif` file is the container itself, the name can be whatever you want.
    The `mydefinition.def` is the path to the `.def` file.
    The `--sandbox` flag is used to create a writable container, so you can shell into it and
    install more packages if needed. If you don't need to install more packages, you can remove the
    `--sandbox` flag.
    > This command will take a while to run (and may appear stuck, but it isn't), depending on the internet connection and the packages.

6. Optional: log into the container and install more packages:
    ```bash
    singularity shell --writable mycontainer.sif
    ```
    You should be in the container shell (`Apptainer>`). You can install more packages, test your script, etc.
    When you are done, type `exit` to exit the container.

7. Exit the interactive session, failing in doing so will make the IT gods angry (DEI):
    ```bash
    exit
    ```

## Step 2: Create a Slurm job file
This section will show you how to create a Slurm job file and submit it to the scheduler. An example
job file is provided in this repository (`myjob.sh`). This is the file we will request the scheduler to run.

For a more detailed explanation of the Slurm scheduler and job examples, refer to the [Using
Slurm](https://docs.dei.unipd.it/en/CLUSTER/using-slurm) and [Slurm Job
Examples](https://docs.dei.unipd.it/en/CLUSTER/SLURMExamples) sections of the DEI cluster
documentation.

To run a python script in the cluster, you need to create a Slurm job file like the following:

`myjob.sh`:
```bash
#!/bin/bash
#SBATCH --job-name=my_first_job
#SBATCH --error=output.%j.err
#SBATCH --output=output.%j.out
#SBATCH --partition=allgroups
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --time=00:02:00
#SBATCH --gres=gpu:a40:1
cd $HOME/slurm_singularity_cluster
echo "Starting job"
srun singularity exec --nv mycontainer.sif python test_script.py
echo "Job finished"
```
The `myjob.sh` file will run the `test_script.py` python script in the `mycontainer.sif` container.

The `#SBATCH` lines are the Slurm directives. They specify the job name, the error and output files,
the partition, the number of tasks, the memory, the time, and the number of GPUs. You can change
these values to suit your needs.

The `srun singularity exec --nv mycontainer.sif python test_script.py` line runs the
`test_script.py` python script in the `mycontainer.sif` container. The `--nv` flag is used to enable
GPU support. You can remove this flag if you don't need GPU support.

## Step 3: Submit the job to the scheduler

To submit the job to the scheduler, type:
```bash
cd slurm_singularity_cluster
sbatch myjob.sh
```

To check the status of the job, type:
```bash
squeue -u <username>
```

To check the output of the job, type:
```bash
cat output.<job_id>.out
```

For more information on how to monitor and manage your jobs, refer to the [Using
Slurm](https://docs.dei.unipd.it/en/CLUSTER/using-slurm) section of the DEI cluster documentation.

## Bonus 1: ssh without password on linux/mac
If you are tired of typing your password every time you connect to the cluster, you can set up an
SSH key pair. This will allow you to connect to the cluster without typing your password.

To set up an SSH key pair, on your local machine (linux or mac) type:
```bash
ssh-keygen -t rsa
```
Press enter to accept the default file location and enter a passphrase (or press enter to skip it).

To copy the public key to the cluster, type:
```bash
ssh-copy-id <username>@login.dei.unipd.it
```
Enter your password when prompted.

Now you can connect to the cluster without typing your password:
```bash
ssh <username>@login.dei.unipd.it
```

## Bonus 2: using tensorboard
If you want to use `tensorboard` to visualize your training stats while the job is running, the best
way I found is to synchronize the tensorboard logs with a local directory. This way you can run the 
tensorboard server on your local machine and visualize the logs in real-time. You can do this by
running the script `sync_tensorboard.sh` in this repository on your local machine. 
> You need to have both `rsync` and `tensorboard` installed on your local machine.
> `Bonus 1` is *highly recommended* to avoid typing your password every time you sync the logs.









