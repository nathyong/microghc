FROM fedora:21
MAINTAINER Nathan Yong <nathyong@gmail.com>
RUN curl https://bintray.com/sbt/rpm/rpm | tee /etc/yum.repos.d/bintray-sbt-rpm.repo
RUN yum -y update
RUN yum -y install ghc llvm scala sbt antlr
