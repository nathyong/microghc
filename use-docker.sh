#!/bin/sh
# Short script to invoke Docker to use as a build environment.

set -ex
docker build -t microghc:latest docker/
docker run -it -v $(pwd):/root/build microghc:latest
