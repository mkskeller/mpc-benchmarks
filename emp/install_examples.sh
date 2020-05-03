#!/bin/bash

# add our files to compile scripts
cp source/* emp-sh2pc/test/
cd emp-sh2pc
mv test/geninput.py .
echo "add_test (mult3)" >> CMakeLists.txt
echo "add_test (innerprod)" >> CMakeLists.txt
echo "add_test (xtabs)" >> CMakeLists.txt

# build project
mkdir build
cd build
cmake ..
make
make install

#Generate mult3 circuit
./bin/mult3 -m
mv mult3.circuit.txt /usr/local/include/emp-tool/circuits/files/

# install malicious 2-party circuits
cd
git clone https://github.com/emp-toolkit/emp-ag2pc.git

#Fix space in error message
sed -i 's/{cout <<ands <<"no match GT!"<<endl<<flush;/{cout <<ands <<" no match GT!"<<endl<<flush;/' ~/emp-ag2pc/emp-ag2pc/2pc.h

cd emp-ag2pc
echo "add_test (agmult3)" >> CMakeLists.txt
mv ../emp-sh2pc/test/agmult3.cpp test/agmult3.cpp
mkdir build
cd build
cmake ..
make 
