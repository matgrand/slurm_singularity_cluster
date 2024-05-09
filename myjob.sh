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