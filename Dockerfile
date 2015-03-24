FROM ubuntu:trusty
MAINTAINER josh < josh [at] gmail {dot} com>

RUN apt-get update && apt-get -y install python-software-properties software-properties-common && \
add-apt-repository "deb http://gb.archive.ubuntu.com/ubuntu $(lsb_release -sc) universe" && \
apt-get update

RUN add-apt-repository ppa:saiarcot895/myppa && \
apt-get update && \
apt-get -y install apt-fast

RUN apt-fast -y install wget

RUN mkdir -p /installs
RUN cd /installs && wget http://downloads.ghostscript.com/public/binaries/ghostscript-9.15-linux-x86_64.tgz
RUN cd /installs && tar -xvf ghostscript-9.15-linux-x86_64.tgz

ENV PATH /installs/ghostscript-9.15-linux-x86_64:$PATH

RUN apt-fast -y install build-essential
RUN cd /installs && wget http://downloads.ghostscript.com/public/ghostpdl-9.15.tar.gz
RUN cd /installs && tar -xvf ghostpdl-9.15.tar.gz
RUN apt-fast -y install autoconf autogen
RUN cd /installs/ghostpdl-9.15 && ./autogen.sh && ./configure && make -j 5 && make install
