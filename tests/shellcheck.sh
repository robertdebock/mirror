#!/bin/sh

docker run -v $(pwd):/data koalaman/shellcheck /data/start.sh
