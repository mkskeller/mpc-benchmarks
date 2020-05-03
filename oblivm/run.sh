cd ObliVMLang

./run-compiler.sh 1234 examples/innerProd/innerProd.lcc

for i in alice bob; do
    python ./genInput.py -i examples/innerProd/human_input_$i.txt -o examples/innerProd/input_$i.txt
done

./runtogether.sh examples/innerProd/input_alice.txt examples/innerProd/input_bob.txt


