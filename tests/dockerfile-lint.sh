#!/bin/sh

docker run -v $(pwd):/data \
  projectatomic/dockerfile-lint \
  dockerfile_lint -f /data/Dockerfile
