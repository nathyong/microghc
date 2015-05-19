#!/bin/bash
set -ex
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

