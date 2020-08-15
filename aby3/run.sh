#!/bin/bash

run()
{
    for i in 0 1 2; do
	time aby3/bin/samples.exe -u innerprod -p $i & true;
    done;

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
