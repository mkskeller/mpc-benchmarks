# put our files in place
cd ~/aby3/
mkdir samples 
mv ~/source/* samples
printf "add_subdirectory(samples)\n" >> CMakeLists.txt

# build entire library
cmake .
make -j8

