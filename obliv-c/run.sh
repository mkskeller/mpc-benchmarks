#!/bin/bash

cd innerProd
make

time ./a.out 1234 -- input1.txt &
time ./a.out 1234 localhost input2.txt


