FROM ubuntu:18.04
WORKDIR /root
RUN apt-get update && apt-get install -y \
  bzip2 \
  clang \
  g++ \
  git \
  make \
  vim \
  wget

#ADD README.md .

ADD install_dependencies.sh .
RUN ["bash", "install_dependencies.sh"]
ADD install.sh .
RUN ["bash", "install.sh"]
ADD source/ /root/source
ADD install_examples.sh .
RUN ["bash", "install_examples.sh"]
CMD ["/bin/bash"]
RUN bash -c "for i in 0 1 2; do time aby3/bin/samples.exe -u innerprod -p $i & true; done;"
