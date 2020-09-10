FROM ubuntu:18.04
WORKDIR /root
RUN apt-get update && apt-get install -y \
  libmpc-dev \
  python3 \
  python3-pip \
  vim \
  iproute2

ADD install.sh .
RUN ["bash", "install.sh"]

ADD source/ /root/source
ADD run.sh .
RUN bash run.sh
