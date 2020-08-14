FROM ubuntu:16.04
WORKDIR /root
RUN apt-get update && apt-get install -y \
  git \
  lzip \
  m4 \
  make \
  libgmp-dev \
  libglib2.0-dev \
  libssl-dev \
  software-properties-common \
  vim \
  wget

ADD install_dependencies.sh .
RUN ["bash", "install_dependencies.sh"]

ADD source/ /root/source
ADD README.md .

ADD install.sh .
RUN ["bash", "install.sh"]
CMD ["/bin/bash"]

ADD run.sh .
RUN ["bash", "run.sh"]
