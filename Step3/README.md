# Input parameter optimization

First we will optimize the energy cut-off and later the number of k-points.

## Energy cutoff
The `energy_cutoff` directory contains a template and two bash scripts.
The `submit_jobs.sh` script creates and submit a set of runs using the template and modifies the energy cutoff parameter `ecutwfc`.  

To run the scripts first edit the script `nano template/submit_jobs.sh` with the correct project parameter and email. 
Make the script executable and run it.
```shell
chmod +x submit_jobs.sh
./submit_jobs.sh
```
Check the job status with `squeue --me`. Once all the jobs finish run the following command to perform the analysis.
```shell
chmod +x analysis.sh
./analysis.sh
```
The result is stored in `data.csv`. It should look like (use `cat data.csv` to see the content of the file)

| ecutwfc | total_energy  | time   |
|---------|---------------|--------|
| 15      | -508.69126778 | 113.49 |
| 20      | -520.09375553 | 150.72 |
| 30      | -527.19933481 | 302.34 |
| 35      | -527.82146108 | 327.47 |
| 40      | -528.00010264 | 424.83 |
| 45      | -528.04379905 | 607.58 |
| 50      | -528.05183076 | 548.88 |
| 55      | -528.05545306 | 626.56 |

The energy should converge for large enough `ecutwfc`, the optimal energy cutoff is such that it is close to the convergent value and minimizes the execution time. 

## K-points

We will follow a similar k-point optimization procedure. We will perform the convergence test inside the `kpoints` directory. 
After selecting the right energy cutoff value we should update the input parameters in our template using the command`nano template/pw.in`. 

![kpoints_changes](figures/kpoints_changes.png)

The second difference in `pw.in` is a label we will use to locate and replace the values of the number of k-points.
The `submit_jobs.sh` script replaces that label with the values we want to test. Similar to the energy cutoff we will run a set of SCF calculation and test convergence in the total energy.

To run the scripts first edit the script `nano template/submit_jobs.sh` with the correct project parameter and email. 
Make the script executable and run it.
```shell
chmod +x submit_jobs.sh
./submit_jobs.sh
```
Check the job status with `squeue --me`. Once all the jobs finish run the following command to perform the analysis.
```shell
chmod +x analysis.sh
./analysis.sh
```
The result is stored in `data.csv`. It should look like (use `cat data.csv` to see the content of the file)

| kxy | kz | total_energy  | time   |
|-----|----|---------------|--------|
| 10  | 1  | -528.06925691 | 48.72  |
| 10  | 10 | -528.07564704 | 302.39 |
| 10  | 11 | -528.07564771 | 303.09 |
| 10  | 2  | -528.07563993 | 101.85 |
| 10  | 5  | -528.07564689 | 152.63 |
| 10  | 6  | -528.07564755 | 206.48 |
| 11  | 1  | -528.06925789 | 59.79  |
| 11  | 2  | -528.07564074 | 116.36 |
| 11  | 5  | -528.07564721 | 175.15 |
| 11  | 6  | -528.07564745 | 231.28 |
| 1   | 1  | -528.06461693 | 5.67   |
| 1   | 10 | -528.07125877 | 22.28  |
| 1   | 11 | -528.07126229 | 22.05  |
| 1   | 2  | -528.07124897 | 8.74   |
| 1   | 5  | -528.07126301 | 12.13  |
| 1   | 6  | -528.07126159 | 15.98  |
| 2   | 1  | -528.06925737 | 9.33   |
| 2   | 10 | -528.07564416 | 45.08  |
| 2   | 11 | -528.07564430 | 45.01  |
| 2   | 2  | -528.07563606 | 16.53  |
| 2   | 5  | -528.07564193 | 23.86  |
| 2   | 6  | -528.07564473 | 30.81  |
| 5   | 1  | -528.06925598 | 18.81  |
| 5   | 10 | -528.07564626 | 110.06 |
| 5   | 11 | -528.07564765 | 109.89 |
| 5   | 2  | -528.07564192 | 38.00  |
| 5   | 5  | -528.07564559 | 56.18  |
| 5   | 6  | -528.07564809 | 73.92  |
| 6   | 1  | -528.06925893 | 27.40  |
| 6   | 10 | -528.07564696 | 151.71 |
| 6   | 11 | -528.07564758 | 152.01 |
| 6   | 2  | -528.07563894 | 52.12  |
| 6   | 5  | -528.07564692 | 77.75  |
| 6   | 6  | -528.07564720 | 102.20 |

Once again we want to select a value close to convergence and minimize the calculation time.
