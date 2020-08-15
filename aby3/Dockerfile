FROM ubuntu:18.04
WORKDIR /root
RUN apt-get update && apt-get install -y \
  bzip2 \
  clang \
  g++ \
  git \
  make \
  vim \
  wget \
  iproute2

#ADD README.md .

ADD install_dependencies.sh .
RUN ["bash", "install_dependencies.sh"]
ADD install.sh .
RUN ["bash", "install.sh"]
ADD source/ /root/source
ADD install_examples.sh .
RUN ["bash", "install_examples.sh"]
CMD ["/bin/bash"]

ADD run.sh .
RUN ["bash", "run.sh"]
