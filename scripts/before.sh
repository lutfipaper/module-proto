#!/bin/bash -e

dir="$(dirname $(realpath ${BASH_SOURCE[0]}))" && cd $dir
dir=$dir/.. && cd $dir

cd $dir

goprotocout=$dir/go 

rm -rf $goprotocout && mkdir -p $goprotocout

export GOBIN=$dir/bin
export GO111MODULE=on

go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.27.1
go get -d github.com/favadi/protoc-go-inject-tag@v1.3.0
export PATH=$GOBIN:$GOPATH/bin:$HOME/go/bin:$PATH

if ! [ -x "$(command -v protoc)" ]; then
    echo "protoc is required"
    exit
fi

if ! [ -x "$(command -v protoc-go-inject-tag)" ]; then
    echo "protoc-go-inject-tag is required"
    exit
fi