set term pdfcairo
set outp "WF_normiert.pdf"

set title "Wellenfunktion normiert"
set xlabel "x"
set ylabel "Psi(x)"
plot "WF_normiert.dat" using 1:2 title "WF", "WF.dat" using 1:2 title "WF normiert"

unset term
unset output

