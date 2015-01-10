FROM ubuntu:14.04
MAINTAINER Georg Koester <mail@georgkoester.de>

RUN apt-get update
RUN apt-get upgrade -y

# haxe dependencies (see .travis.yml and experience)
RUN apt-get install -y  ocaml zlib1g-dev libgc-dev neko mysql-server git sqlite3 libsqlite3-dev libpcre3 libpcre3-dev && apt-get clean

# some packages (not mysql) also installed during test run, but here you can integrate them in the docker image, reducing container size.

# optional1, add packages required for js tests (node)
RUN apt-get install -y  npm nodejs && apt-get clean
RUN ln -s /usr/bin/nodejs /usr/bin/node
# END optional1

# optional2, add packages required for java tests (oracle jdk)
RUN apt-get install -y software-properties-common && apt-get clean
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
# auto accept oracle jdk license
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -yq oracle-java8-installer # could clean /var/cache/oracle-jdk8-installer or the tar in there (150mb)
# END optional2

# optional3, sets up mysql for php test and adds php packages to docker image
# Mysql is necessary to run php tests.
RUN apt-get install -y php5 php5-mysql php5-sqlite mysql-server && apt-get clean
RUN /etc/init.d/mysql start && mysql -u root -e 'create database haxe_test;' && mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'travis'@'localhost';"
# END optional3

# optional4, add required packages for cpp tests to docker image
RUN apt-get install -y gcc-multilib g++-multilib && apt-get clean
# END optional4

# optional5, add required packages for cs tests to docker image
RUN apt-get install -y mono-devel mono-mcs && apt-get clean
# END optional5

ADD haxe /haxe

