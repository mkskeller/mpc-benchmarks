#!/bin/bash

cd emp-sh2pc

python ~/emp-sh2pc/geninput.py -e innerprod -n 32 -l 100000

cd build

for i in 0 1; do
    time ./bin/innerprod $i 1234 32 & true
done

wait
