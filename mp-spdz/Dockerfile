FROM ubuntu:20.04
WORKDIR /root

RUN apt-get update
RUN apt-get install -y make
RUN apt-get install -y git
RUN apt-get install -y clang++-6
RUN apt-get install -y libsodium-dev
RUN apt-get install -y autoconf
RUN apt-get install -y automake
RUN apt-get install -y libtool
RUN apt-get install -y yasm
ENV TZ=Australia/Sydney
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get install -y texinfo
RUN apt-get install -y libboost-dev
RUN apt-get install -y libssl-dev
RUN apt-get install -y libntl-dev
RUN apt-get install -y gcc
RUN apt-get install -y libboost-system1.71-dev
RUN apt-get install -y iproute2
RUN apt-get install -y time

RUN git clone https://github.com/data61/MP-SPDZ -b v0.1.9
WORKDIR /root/MP-SPDZ

RUN git submodule update --init mpir
RUN make -j4 mpir

RUN echo CXX = clang++ >> CONFIG.mine
RUN echo USE_NTL = 1 >> CONFIG.mine

RUN make -j4 replicated-ring-party.x
RUN make -j4 shamir-party.x malicious-shamir-party.x semi2k-party.x
RUN make -j4 chaigear-party.x
RUN echo MY_CFLAGS += -DFIXED_REGISTERS=1 >> CONFIG.mine
RUN make -j4 yao-party.x

ADD dot.mpc Programs/Source

RUN ./compile.py dot 100000
RUN ./compile.py -DB 32 dot 100000 B

RUN Scripts/setup-ssl.sh
RUN seq 100000 > Player-Data/Input-P0-0
RUN seq 100000 > Player-Data/Input-P1-0

ADD run*.sh ./
RUN bash run-sh2.sh
RUN bash run-sh3.sh
RUN bash run-shamir.sh
RUN bash run-mal-shamir.sh
RUN bash run-yao.sh
RUN bash run-high.sh
