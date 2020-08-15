FROM ubuntu:18.04

WORKDIR /root

# Install required packages
RUN apt-get update && apt-get install -y \
  bzip2 \
  curl \
  doxygen \
  g++ \
  gcc \
  git \
  libcrypto++-dev \
  libgmp3-dev \
  libssl-dev \
  m4 \
  make \
  patch \
  python \
  vim \
  wget \
  yasm \
  zip

ADD install_dependencies.sh .
RUN ["bash", "install_dependencies.sh"]

RUN git clone https://github.com/KULeuven-COSIC/SCALE-MAMBA.git

ADD source/ /root/source
ADD install.sh .
RUN ["bash", "install.sh"]

ADD README.md .

ENV PATH ~/.cargo/bin/:${PATH}

CMD ["/bin/bash"]

RUN apt-get install -y iproute2

ADD run-*.sh ./
RUN "bash" "run-shamir.sh"
RUN "bash" "run-high.sh"
