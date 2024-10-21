set xrange [0:150]
plot "data/IceIh_experimental_3K.txt" u 2:3 w l lw 3 t "Experimental (3K)", "data/matdyn.dos" u (0.124*$1):($2*0.5e7) w l lw 3 t "Calculated"
pause -1
