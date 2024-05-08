#!/bin/bash
#SBATCH --job-name=my_first_job
#SBATCH --error=output.%j.err
#SBATCH --output=output.%j.out
#SBATCH --partition=allgroups
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --time=00:05:00
#SBATCH --gres=gpu:a40:1

echo "Working directory is $WORKING_DIR"
echo "Files: $(ls $WORKING_DIR)"
cd $WORKING_DIR
echo "Starting job"

srun singularity exec --nv mycontainer/mycontainer.sif python test_script.py