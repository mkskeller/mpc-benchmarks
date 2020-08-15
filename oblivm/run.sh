cd ObliVMLang

./run-compiler.sh 1234 examples/innerProd/innerProd.lcc

for i in alice bob; do
    python ./genInput.py -i examples/innerProd/human_input_$i.txt -o examples/innerProd/input_$i.txt
done

run()
{
    ./runtogether.sh examples/innerProd/input_alice.txt examples/innerProd/input_bob.txt
}



run2()
{
    ip -s link show lo 
    run
}


tc qdisc del dev lo root

#run2
#run2

bwlimit=100mbit
delay=50ms

tc qdisc add dev lo root netem rate $bwlimit delay $delay
echo rate $bwlimit delay $delay

run2
run2
