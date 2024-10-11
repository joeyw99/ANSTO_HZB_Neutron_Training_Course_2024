#!/bin/bash --login
#SBATCH --account=pawseyXXXX
#SBATCH --partition=work
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=32
#SBATCH --time=12:00:00
#SBATCH --mem=50GB
#SBATCH --output=stdout.txt
#SBATCH --error=stderr.txt
#SBATCH --mail-type=END
#SBATCH --mail-user=user@email.com
#SBATCH --job-name=IceIh_RELAX

export OMP_NUM_THREADS=1
# ---
# Temporal workaround for avoiding Slingshot issues on shared nodes:
FI_CXI_DEFAULT_VNI=$(od -vAn -N4 -tu < /dev/urandom)
export FI_CXI_DEFAULT_VNI

module load quantum-espresso/7.2

# -----Executing command:
srun -u -N "$SLURM_JOB_NUM_NODES" -n "$SLURM_NTASKS" -c "$OMP_NUM_THREADS" -m block:block:block pw.x -in pw.in > pw.out
srun -u -N "$SLURM_JOB_NUM_NODES" -n "$SLURM_NTASKS" -c "$OMP_NUM_THREADS" -m block:block:block ph.x -in ph.in > ph.out
srun -u -N "$SLURM_JOB_NUM_NODES" -n "$SLURM_NTASKS" -c "$OMP_NUM_THREADS" -m block:block:block q2r.x -in q2r.in > q2r.out
srun -u -N "$SLURM_JOB_NUM_NODES" -n "$SLURM_NTASKS" -c "$OMP_NUM_THREADS" -m block:block:block matdyn.x -in matdyn.in > matdyn.out
#=====END====
