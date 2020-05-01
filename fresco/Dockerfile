FROM ubuntu:18.04
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y openjdk-8-jdk maven
WORKDIR /home/fresco-samples
ADD pom.xml /home/fresco-samples
RUN mvn package
ADD . /home/fresco-samples
RUN mvn package -X
RUN bash -c "for i in 1 2; do time java -jar target/innerprod.jar $i & true; done; wait"
