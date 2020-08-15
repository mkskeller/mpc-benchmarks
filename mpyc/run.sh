#!/bin/bash

cd source

run()
{
    for i in $(seq 10); do
	ip -s link show lo 
	python innerprod.py -M 3
	ip -s link show lo 
    done
}





run2()
{
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
