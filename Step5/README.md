# Phonon calculation 

We will perform the phonon calculation in five steps. We need one parameter file for each step: `pw.in, ph.in, q2r.in, matdyn.dos.in and matdyn.in`.  
Energy cut-off, k-points and ions' positions are the changes from the initial `pw.in` parameter files. 
![pw_changes.png](figures/pw_changes.png)
![pw_changes_2.png](figures/pw_changes_2.png)

The Setonix script job runs the five commands in sequence:
```
# -----Executing command:
srun -u -N "$SLURM_JOB_NUM_NODES" -n "$SLURM_NTASKS" -c "$OMP_NUM_THREADS" -m block:block:block pw.x -in pw.in > pw.out
srun -u -N "$SLURM_JOB_NUM_NODES" -n "$SLURM_NTASKS" -c "$OMP_NUM_THREADS" -m block:block:block ph.x -in ph.in > ph.out
srun -u -N "$SLURM_JOB_NUM_NODES" -n "$SLURM_NTASKS" -c "$OMP_NUM_THREADS" -m block:block:block q2r.x -in q2r.in > q2r.out
srun -u -N "$SLURM_JOB_NUM_NODES" -n "$SLURM_NTASKS" -c "$OMP_NUM_THREADS" -m block:block:block matdyn.x -in matdyn.dos.in > matdyn.dos.out
srun -u -N "$SLURM_JOB_NUM_NODES" -n "$SLURM_NTASKS" -c "$OMP_NUM_THREADS" -m block:block:block matdyn.x -in matdyn.in > matdyn.out
#=====END====
```
The first command, `pw.x`, runs a self-consistent field calculation. The second command, `ph.x`, performs the phonon calculation using Density-Functional Perturbation Theory (DFPT). The third command, `q2r.x`, reads force constant matrices *C(q)* produced by the `ph.x` code
for a grid of q-points and calculates the corresponding set of interatomic force constants. Finally, `matdyn.x` calculates the phonon frequencies for a list of generic *q* vectors.

The detailed documentation for each command is in the following [link](https://www.quantum-espresso.org/documentation/input-data-description/). 

The `ph.in` file has the following parameters:
```text
Phonon dispersion
 &INPUTPH
  prefix='IceIh',
  tr2_ph = 1.0d-14,
  amass(1) = 1.00794,
  amass(2) = 15.9994
  ldisp = .true.,
  nq1 = 4,
  nq2 = 4,
  nq3 = 4,
  outdir='./out'
  fildyn='IceIh.dyn',
 /
```
**Note: the `prefix` and `out` parameters should be the same for `pw.in` and `ph.in` input files.**
The `q2r.in` file has the following parameters:
```text
&input
   fildyn='IceIh.dyn',
   zasr='simple',
   flfrc='IceIh.fc'
 /
```
**Note: the `fildyn` parameter should be the same for `ph.in` and `q2r.in` input files.**
The `matdyn.x` command has two input files: one to compute the phonon density of states and the other to compute the band dispersion.
The `matdyn.dos.in` file has the following parameters:
```text
&INPUT
 asr='simple'
 amass(1) = 1.00794
 amass(2) = 15.9994
 flfrc='IceIh.fc'
 dos = .true
 nk1 = 4
 nk2 = 4
 nk3 = 4
 deltaE = 1
 degauss = 8.065610
 flfrq = 'IceIh.dos.freq'
 flvec = 'IceIh.dos.modes'
 fleig = 'IceIh.dos.eig'
 fldyn = 'IceIh.dos.dynmat'
/
```
The `matdyn.in` file has the following parameters:
```text
&input
asr='simple'
amass(1) = 1.00794
amass(2) = 15.9994
flfrc='IceIh.fc'
flfrq='IceIh.freq'
/
93
0.0000000	0.0000000	0.0000000	1.0
0.0000000	0.0000000	0.0416667	1.0
0.0000000	0.0000000	0.0833333	1.0
0.0000000	0.0000000	0.1250000	1.0
0.0000000	0.0000000	0.1666667	1.0
0.0000000	0.0000000	0.2083333	1.0
0.0000000	0.0000000	0.2500000	1.0
0.0000000	0.0000000	0.2916667	1.0
0.0000000	0.0000000	0.3333333	1.0
0.0000000	0.0000000	0.3750000	1.0
0.0000000	0.0000000	0.4166667	1.0
0.0000000	0.0000000	0.4583333	1.0
0.0000000	0.0000000	0.5000000	1.0
0.0166665	0.0166665	0.4750000	1.0
0.0333330	0.0333330	0.4500000	1.0
0.0499995	0.0499995	0.4250000	1.0
0.0666660	0.0666660	0.4000000	1.0
0.0833325	0.0833325	0.3750000	1.0
0.0999990	0.0999990	0.3500000	1.0
0.1166655	0.1166655	0.3250000	1.0
0.1333320	0.1333320	0.3000000	1.0
0.1499985	0.1499985	0.2750000	1.0
0.1666650	0.1666650	0.2500000	1.0
0.1833315	0.1833315	0.2250000	1.0
0.1999980	0.1999980	0.2000000	1.0
0.2166645	0.2166645	0.1750000	1.0
0.2333310	0.2333310	0.1500000	1.0
0.2499975	0.2499975	0.1250000	1.0
0.2666640	0.2666640	0.1000000	1.0
0.2833305	0.2833305	0.0750000	1.0
0.2999970	0.2999970	0.0500000	1.0
0.3166635	0.3166635	0.0250000	1.0
0.3333300	0.3333300	0.0000000	1.0
0.3333300	0.3333300	0.0416667	1.0
0.3333300	0.3333300	0.0833333	1.0
0.3333300	0.3333300	0.1250000	1.0
0.3333300	0.3333300	0.1666667	1.0
0.3333300	0.3333300	0.2083333	1.0
0.3333300	0.3333300	0.2500000	1.0
0.3333300	0.3333300	0.2916667	1.0
0.3333300	0.3333300	0.3333333	1.0
0.3333300	0.3333300	0.3750000	1.0
0.3333300	0.3333300	0.4166667	1.0
0.3333300	0.3333300	0.4583333	1.0
0.3333300	0.3333300	0.5000000	1.0
0.3437469	0.3124969	0.4687500	1.0
0.3541638	0.2916638	0.4375000	1.0
0.3645806	0.2708306	0.4062500	1.0
0.3749975	0.2499975	0.3750000	1.0
0.3854144	0.2291644	0.3437500	1.0
0.3958312	0.2083313	0.3125000	1.0
0.4062481	0.1874981	0.2812500	1.0
0.4166650	0.1666650	0.2500000	1.0
0.4270819	0.1458319	0.2187500	1.0
0.4374988	0.1249988	0.1875000	1.0
0.4479156	0.1041656	0.1562500	1.0
0.4583325	0.0833325	0.1250000	1.0
0.4687494	0.0624994	0.0937500	1.0
0.4791663	0.0416663	0.0625000	1.0
0.4895831	0.0208331	0.0312500	1.0
0.5000000	0.0000000	0.0000000	1.0
0.5000000	0.0000000	0.0416667	1.0
0.5000000	0.0000000	0.0833333	1.0
0.5000000	0.0000000	0.1250000	1.0
0.5000000	0.0000000	0.1666667	1.0
0.5000000	0.0000000	0.2083333	1.0
0.5000000	0.0000000	0.2500000	1.0
0.5000000	0.0000000	0.2916667	1.0
0.5000000	0.0000000	0.3333333	1.0
0.5000000	0.0000000	0.3750000	1.0
0.5000000	0.0000000	0.4166667	1.0
0.5000000	0.0000000	0.4583333	1.0
0.5000000	0.0000000	0.5000000	1.0
0.4750000	0.0000000	0.4750000	1.0
0.4500000	0.0000000	0.4500000	1.0
0.4250000	0.0000000	0.4250000	1.0
0.4000000	0.0000000	0.4000000	1.0
0.3750000	0.0000000	0.3750000	1.0
0.3500000	0.0000000	0.3500000	1.0
0.3250000	0.0000000	0.3250000	1.0
0.3000000	0.0000000	0.3000000	1.0
0.2750000	0.0000000	0.2750000	1.0
0.2500000	0.0000000	0.2500000	1.0
0.2250000	0.0000000	0.2250000	1.0
0.2000000	0.0000000	0.2000000	1.0
0.1750000	0.0000000	0.1750000	1.0
0.1500000	0.0000000	0.1500000	1.0
0.1250000	0.0000000	0.1250000	1.0
0.1000000	0.0000000	0.1000000	1.0
0.0750000	0.0000000	0.0750000	1.0
0.0500000	0.0000000	0.0500000	1.0
0.0250000	0.0000000	0.0250000	1.0
0.0000000	0.0000000	0.0000000	1.0
```
This file includes paths in reciprocal space that generates the band structure. We can find suggested path using the [seekpath](https://www.materialscloud.org/work/tools/seekpath) online tool.
We can use the `pw.in` file to generate the suggested paths. 
![seekpath_1.png](figures/seekpath_1.png)

The tool gives us a visualization of the reciprocal space and the coordinates of the paths. 

![seekpath_2.png](figures/seekpath_2.png)


```
Γ 	0.0000000000 	0.0000000000 	0.0000000000
A 	0.0000000000 	0.0000000000 	0.5000000000
K 	0.3333333333 	0.3333333333 	0.0000000000
H 	0.3333333333 	0.3333333333 	0.5000000000
M 	0.5000000000 	0.0000000000 	0.0000000000
L 	0.5000000000 	0.0000000000 	0.5000000000
Γ 	0.0000000000 	0.0000000000 	0.0000000000
```


| From | To | Distance    |
|------|----|-------------|
| Γ    | A  | 0.500000000 |
| A    | K  | 1.187184271 |
| K    | H  | 1.687184271 |
| H    | M  | 2.310793835 |
| M    | L  | 2.810793835 |
| L    | Γ  | 3.517900617 |






