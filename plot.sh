#!/bin/bash
function do_plot {
    survey=$1

    gnuplot <<EOF
        set terminal pngcairo size 1000,700 font "Helvetica Neue,12pt"
        set output "plots/$survey.png"

        set linestyle 1 lt 1 lw 1.5 lc rgb "#1f77b4"
        set linestyle 2 lt 2 lw 1.5 lc rgb "#ff7f0e"
        set linestyle 3 lt 3 lw 1.5 lc rgb "#2ca02c"
        set linestyle 4 lt 4 lw 1.5 lc rgb "#d62728"
        set linestyle 5 lt 5 lw 1.5 lc rgb "#ac61c7"

        set xdata time
        set timefmt "%Y%m%d"
        set format x "%d-%b"
        set xtics rotate
        set xrange ["20140701":"20140918"]
        set xtics "20140703",604800

        set border 3
        set tics nomirror
        set grid

        set yrange [0:100]
        set ytics 0,10

        set xlabel "poll completion date"
        set ylabel "percent"

        plot "data/$survey.data" using 1:2 w lines ls 1 ti "yes",\
                '' using 1:2:5 w yerrorbars notitle ls 1,\
                '' using 1:3 w lines ls 2 ti "no",\
                '' using 1:3:5 w yerrorbars noti ls 2,\
                '' using 1:4 w lines ls 3 ti "undecided/won't vote"

EOF
}

function do_bigger_plot {
    col=$1
    out=$2
    title=$3

    gnuplot <<EOF
        set terminal pngcairo size 1000,700 font "Helvetica Neue,12pt"
        set output "plots/$out"

        set linestyle 1 lt 1 lw 1.5 lc rgb "#1f77b4"
        set linestyle 2 lt 2 lw 1.5 lc rgb "#ff7f0e"
        set linestyle 3 lt 3 lw 1.5 lc rgb "#2ca02c"
        set linestyle 4 lt 4 lw 1.5 lc rgb "#d62728"
        set linestyle 5 lt 5 lw 1.5 lc rgb "#ac61c7"

        set xdata time
        set timefmt "%Y%m%d"
        set format x "%Y-%m-%d"
        set format x "%d-%b"
        set xtics rotate
        set xrange ["20140701":"20140918"]
        set xtics "20140703",604800

        set border 3
        set tics nomirror
        set grid

        set yrange [0:100]
        set ytics 0,10

        set xlabel "poll completion date"
        set ylabel "percent"

        set title "$title"

        plot 'data/icm.data' using 1:$col w lines ls 1 ti "icm",\
                '' using 1:$col:5 w yerrorbars notitle ls 1,\
                'data/panelbase.data' using 1:$col w lines ls 2 ti "panelbase",\
                '' using 1:$col:5 w yerrorbars noti ls 2,\
                'data/survation.data' using 1:$col w lines ls 3 ti "survation",\
                '' using 1:$col:5 w yerrorbars noti ls 3,\
                'data/tns-bmrb.data' using 1:$col w lines ls 4 ti "tns-bmrb",\
                '' using 1:$col:5 w yerrorbars noti ls 4,\
                'data/yougov.data' using 1:$col w lines ls 5 ti "yougov",\
                '' using 1:$col:5 w yerrorbars noti ls 5

EOF
}


do_plot icm
do_plot panelbase
do_plot survation
do_plot tns-bmrb
do_plot yougov

do_bigger_plot 2 all-yesses.png "proportion yesses"
do_bigger_plot 3 all-noes.png "proportion noes"


