.PHONY: all
SHELL := /bin/bash
PATH := $(HOME)/.cabal/bin:./sandbox/bin:./bin/sbt/bin:$(PATH)

UNAME := $(shell uname)

all:
	false

deps-all:
	git submodule update --init

deps-mu: deps-all
	mkdir -p bin && cd bin
	[ -f sbt-0.13.8.tgz ] || wget https://dl.bintray.com/sbt/native-packages/sbt/0.13.8/sbt-0.13.8.tgz
	[ -d sbt ] || tar xzvf sbt-0.13.8.tgz

deps-ghc: deps-all
	cabal update
	cabal install -j cabal-install
	cabal sandbox init --sandbox=sandbox
	cabal install -j alex happy
	cabal install -j haskell-src-exts
	cd microghc-ghc && cabal sandbox init --sandbox=../sandbox

stage-mu: deps-mu
	cd microvm-refimpl2
	sbt update
	sbt antlr4:antlr4Generate
	sbt compile

stage-ghc: deps-ghc
	cd microghc-ghc
	git reset --hard
	patch -Np1 < ../patches/ghc-hardcode-submodules.patch || echo "Patch already applied, or something broke, moving on."
	patch -Np1 < ../patches/ghc-add-build-mk.patch || echo "Patch already applied, or something broke, moving on."
	git submodule update --init
	git pull
	make distclean
	./boot
	./configure
	make -j16
