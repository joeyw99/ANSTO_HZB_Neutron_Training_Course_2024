#!/bin/bash

echo "kxy,kz,total_energy,time" > data.csv

for output_dir in kx_*
do
    var1=$(echo  $output_dir | cut -f 2 -d "_" | grep -Eo '[+-]?[0-9]+([.][0-9]+)?')
    var2=$(echo  $output_dir | cut -f 6 -d "_" | grep -Eo '[+-]?[0-9]+([.][0-9]+)?')
    value1=$(egrep  '^!\s+total energy'  $output_dir/pw.out | grep -Eo '[+-]?[0-9]+([.][0-9]+)?')
    vartime=$(tail $output_dir/pw.out | egrep "PWSCF\s+:" | cut -f 2 -d "U" | cut -f 1 -d "W")
    seconds=$(echo $vartime | grep -Eo "[+-]?[0-9]+([.][0-9]+)?s" | grep -Eo '[+-]?[0-9]+([.][0-9]+)?')
    seconds="${seconds:-0}"

    minutes=$(echo $vartime | grep -Eo "[+-]?[0-9]+([.][0-9]+)?m" | grep -Eo '[+-]?[0-9]+([.][0-9]+)?')
    minutes="${minutes:-0}"

    hours=$(echo $vartime | grep -Eo "[+-]?[0-9]+([.][0-9]+)?h" | grep -Eo '[+-]?[0-9]+([.][0-9]+)?')
    hours="${hours:-0}"
    echo $var1,$var2,$value1,$(echo $hours*3600+$minutes*60+$seconds | bc) >> data.csv
done