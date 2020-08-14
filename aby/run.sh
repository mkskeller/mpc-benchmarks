#!/bin/bash

cd ABY/build/bin

run()
{
    ip -s link show lo 

    for i in 0 1; do
	time ./innerprod_test -r $i -n 100000 -b 64 & true;
    done
    
    ip -s link show lo 
    
    wait
}

run
run

bwlimit=100mbit
delay=50ms

#apt install tc -y

tc qdisc del dev lo root
tc qdisc add dev lo root netem rate $bwlimit delay $delay
echo rate $bwlimit delay $delay


run
run
