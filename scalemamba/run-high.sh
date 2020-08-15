#!/bin/bash

cd SCALE-MAMBA
#cp /root/source/innerprod* Programs/innerprod
#cp Auto-Test-Data/Cert-Store/* Cert-Store

run3()
{
    for i in 0 1; do
	./Player.x -dOT -max 100000,1,1 $i Programs/innerprod & true
    done
    wait
}

run()
{
    cp -av Auto-Test-Data/20/* Data
    run3
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
