#!/bin/bash --login
#SBATCH --account=pawseyXXXX
#SBATCH --partition=work
#SBATCH --nodes=1
#SBATCH --time=1:00:00
#SBATCH --mem=50GB
#SBATCH --output=stdout.txt
#SBATCH --error=stderr.txt
#SBATCH --mail-type=END
#SBATCH --mail-user=user@email.com
#SBATCH --job-name=IceIh_SCF

export OMP_NUM_THREADS=1
# ---
# Temporal workaround for avoiding Slingshot issues on shared nodes:
FI_CXI_DEFAULT_VNI=$(od -vAn -N4 -tu < /dev/urandom)
export FI_CXI_DEFAULT_VNI

module load quantum-espresso/7.2

# -----Executing command:
srun -u -N "$SLURM_JOB_NUM_NODES" -n "$SLURM_NTASKS" -c "$OMP_NUM_THREADS" -m block:block:block pw.x -in pw.in > pw.out
#=====END====
