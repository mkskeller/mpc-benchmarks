#!/bin/bash

cd emp-sh2pc

python ~/emp-sh2pc/geninput.py -e innerprod -n 32 -l 100000

run()
{
    for i in 0 1; do
	time ./build/bin/innerprod $i 1234 32 & true
    done
    
    wait
}



run2()
{
    ip -s link show lo 
    run
}


tc qdisc del dev lo root

run2
run2

bwlimit=100mbit
delay=50ms

tc qdisc add dev lo root netem rate $bwlimit delay $delay
echo rate $bwlimit delay $delay

run2
run2
