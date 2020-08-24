run2()
{
    ip -s link show lo
    prefix=time $*
}


tc qdisc del dev lo root

run2 $*
run2 $*

bwlimit=100mbit
delay=50ms

tc qdisc add dev lo root netem rate $bwlimit delay $delay
echo rate $bwlimit delay $delay

run2 $*
run2 $*
