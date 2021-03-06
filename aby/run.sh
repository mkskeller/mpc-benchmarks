#!/bin/bash

cd ABY/build/bin

run()
{
    for i in 0 1; do
	time ./innerprod_test -r $i -n 100000 -b 64 & true;
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

#apt install tc -y

tc qdisc add dev lo root netem rate $bwlimit delay $delay
echo rate $bwlimit delay $delay

run2
run2
