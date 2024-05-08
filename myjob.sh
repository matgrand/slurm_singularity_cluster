#!/bin/bash
#SBATCH --job-name=my_first_job
#SBATCH --error=output.%j.err
#SBATCH --output=error.%j.out
#SBATCH --partition=allgroups
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --time=00:05:00
#SBATCH --gres=gpu

cd $WORKING_DIR

srun singularity exec --nv .mycontainer/mycontainer.sif python test_script.py