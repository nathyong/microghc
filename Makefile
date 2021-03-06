.PHONY: all deps-all deps-mu deps-ghc $(STAGES)
SHELL := /bin/bash
PATH := $(HOME)/.cabal/bin:$(PWD)/sandbox/bin:$(PWD)/bin/sbt/bin:$(PATH)

UNAME := $(shell uname)
STAGES = stage-mu stage-ghc

all:
	false

deps-all:
	@echo Updating submodules
	@git submodule update --init

deps-mu: deps-all
	@echo Getting dependencies for building Mu
	@echo Getting sbt
	@mkdir -p bin
	@cd bin; [ -f sbt-0.13.8.tgz ] || wget https://dl.bintray.com/sbt/native-packages/sbt/0.13.8/sbt-0.13.8.tgz
	@cd bin; [ -d sbt ] || tar xzvf sbt-0.13.8.tgz

deps-ghc: deps-all
	@echo Updating cabal-install
	@cabal update
	@cabal install -j cabal-install
	@echo Initialising cabal sandbox
	@cabal sandbox init --sandbox=sandbox
	@cd ghc && cabal sandbox init --sandbox=../sandbox
	@echo Installing dependencies for building GHC
	@cabal install -j alex happy
	@cabal install -j haskell-src-exts

$(STAGES): stage-% : deps-%
	@echo Running $@
	@$(SHELL) scripts/$@.sh
