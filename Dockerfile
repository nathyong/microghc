# This is a comment
FROM ubuntu:14.04
MAINTAINER Nathan Yong <nathyong@gmail.com>
RUN echo "deb http://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list
RUN apt-get update 
RUN apt-get install -y ghc llvm scala sbt antlr
