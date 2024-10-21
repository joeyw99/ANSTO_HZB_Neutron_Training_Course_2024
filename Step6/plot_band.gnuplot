set termoption enhanced
cf=0.124

G1=0
A1=0.5
K1=1.187184271
H1=1.687184271
M1=2.310793835
L1=2.810793835
G2=3.517900617

set yrange [0:20]
set arrow from A1,0 to A1,20 nohead dashtype 3 lw 2
set arrow from K1,0 to K1,20 nohead dashtype 3 lw 2
set arrow from H1,0 to H1,20 nohead dashtype 3 lw 2
set arrow from M1,0 to M1,20 nohead dashtype 3 lw 2
set arrow from L1,0 to L1,20 nohead dashtype 3 lw 2

set style line 1 lc rgb '#000000' lt 1 lw 2 pi -1 ps 1.0

set xtics ("{/Symbol G}" G1, "A" A1, "K" K1, "H" H1, "M" M1, "L" L1, "{/Symbol G}" G2)
plot "data/IceIh.freq.gp" u 1:($2*cf) w l ls 1 not, \
    "" u 1:($3*cf) w l  ls 1 not, \
    "" u 1:($4*cf) w l  ls 1 not, \
    "" u 1:($5*cf) w l  ls 1 not, \
    "" u 1:($6*cf) w l  ls 1 not, \
    "" u 1:($7*cf) w l  ls 1 not, \
    "" u 1:($8*cf) w l  ls 1 not, \
    "" u 1:($9*cf) w l  ls 1 not, \
    "" u 1:($10*cf) w l  ls 1 not, \
    "" u 1:($11*cf) w l  ls 1 not, \
    "" u 1:($12*cf) w l  ls 1 not, \
    "" u 1:($13*cf) w l  ls 1 not, \
    "" u 1:($14*cf) w l  ls 1 not, \
    "" u 1:($15*cf) w l  ls 1 not, \
    "" u 1:($16*cf) w l  ls 1 not, \
    "" u 1:($17*cf) w l  ls 1 not, \
    "" u 1:($18*cf) w l  ls 1 not, \
    "" u 1:($19*cf) w l  ls 1 not
pause -1