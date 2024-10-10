#!/bin/bash

for var1 in 30 40 50 60 70
do
        output_dir="ecutwfc_${var1}"
        cp -r template $output_dir
        cd $output_dir || exit
        sed -i "s/.*ecutwfc.*/    ecutwfc = $var1,/" pw.in
        sbatch --job-name="${output_dir}" setonix_job.sh
        cd ..
done
