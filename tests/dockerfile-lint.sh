#!/bin/sh

docker run -it --rm --privileged -v $(pwd):/data/ \
           projectatomic/dockerfile-lint \
           dockerfile_lint -f /data/Dockerfile
