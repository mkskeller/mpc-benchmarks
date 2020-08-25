This repository contains Docker containers used for the benchmarks in the [paper](https://eprint.iacr.org/2020/521) about [MP-SPDZ](https://github.com/data61/MP-SPDZ). It is based on work by [Hastings et al.](https://github.com/MPC-SOK/frameworks)

### Usage

First set up Docker by running the following in the sub-directory named after a framework:

```
docker build -t <framework> .
```

The setup script will already run the benchmarks. However, traffic control requires extra permissions, so for the benchmarks including WAN setting run the container as follows:

```
docker run --cap-add=NET_ADMIN -it <framework>
```

Then you can run the benchmarking script, by calling `bash run.sh` or `bash run-<protocol>.sh`. The latter is for framework implementing several protocols. See the directory listing for the options. All scripts first run the benchmark twice without network restrictions and then twice in a WAN setting with 100ms RTT and 100 Mbps bandwidth.
