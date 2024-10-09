#!/bin/bash

for var1 in 1 2 5 6 8
do
    for var2 in 1 2 5 6 8
    do
        output_dir="kx_${var1}_ky_${var1}_kz_${var2}"
        cp -r template $output_dir
        cd $output_dir || exit
        sed -i "s/.*kx ky kz.*/${var1} ${var1} ${var2} 0 0 0/" pw.scf.in
        sbatch --job-name="${output_dir}" setonix_job.sh
        cd ..
    done
done
