#!/bin/bash

cd tests

python ~/source/geninput.py -e innerprod -l 100000

cd innerprod

cat data/input.[AB].dat > data/input

picco-utility -I 1 data/input util_config secure_server/share

cd secure_server

run()
{
    time ./innerprod 3 run_config keys/private3.pem 1 1 share3 output & true
    sleep 1
    time ./innerprod 2 run_config keys/private2.pem 1 1 share2 output & true
    sleep 1
    time ./innerprod 1 run_config keys/private1.pem 1 1 share1 output & true
    sleep 1

    picco-seed run_config ../util_config

    wait

    picco-utility -O 1 output ../util_config result

    cat result
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

