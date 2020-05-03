FROM ubuntu:16.04
WORKDIR /root
RUN apt-get update && apt-get install -y \
  build-essential \
  cmake \
  git \
  libgmp-dev \
  libssl-dev \
  sudo \
  software-properties-common \
  vim
ADD README.md .
ADD install.sh .
RUN ["bash", "install.sh"]
CMD ["/bin/bash"]

ADD source/ /root/source
ADD install_examples.sh .
RUN ["bash", "install_examples.sh"]

ADD run.sh .
RUN bash run.sh
