#!/bin/bash
set -ex
cd microvm-refimpl2
sbt update
sbt antlr4:antlr4Generate
sbt compile
