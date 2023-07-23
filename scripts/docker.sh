#!/bin/bash 
dir="$(dirname $(realpath ${BASH_SOURCE[0]}))" && cd $dir
dir=$dir/.. && cd $dir

mkdir -p $HOME/go/docker/

docker container run --rm \
-v $dir:/data/ \
-v $HOME/go/docker:/go \
-w /data \
-u $(id -u ${USER}):$(id -g ${USER}) \
afisme/golang:1.17 ./scripts/go-proto.sh
