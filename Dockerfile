FROM ubuntu:14.04
MAINTAINER Georg Koester <mail@georgkoester.de>

RUN apt-get update
RUN apt-get upgrade -y

# node
RUN apt-get install -y  npm nodejs && apt-get clean
RUN ln -s /usr/bin/nodejs /usr/bin/node

# java
RUN apt-get install -y software-properties-common && apt-get clean
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
# auto accept oracle jdk license
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -yq oracle-java8-installer # could clean /var/cache/oracle-jdk8-installer or the tar in there (150mb)

# haxe dependencies (see .travis.yml and experience)
RUN apt-get install -y  ocaml zlib1g-dev libgc-dev neko mysql-server git sqlite3 libsqlite3-dev libpcre3 libpcre3-dev && apt-get clean

# optional, this is also installed during cpp test run, but here you could integrate it in the docker image:
RUN apt-get install -y gcc-multilib g++-multilib php5 && apt-get clean

ADD haxe /haxe

