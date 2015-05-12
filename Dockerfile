FROM ubuntu:14.04
MAINTAINER Nathan Yong <nathyong@gmail.com>
RUN apt-get update
RUN apt-get install -y wget ghc llvm antlr build-essential git
RUN wget http://dl.bintray.com/sbt/debian/sbt-0.13.8.deb
RUN dpkg -i sbt-0.13.8.deb
VOLUME /root
WORKDIR /root
