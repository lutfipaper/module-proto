#!/bin/bash -e

dir="$(dirname $(realpath ${BASH_SOURCE[0]}))" && cd $dir
dir=$dir/.. && cd $dir

cd $dir

goprotocout=$dir/go

rm -rf $goprotocout && mkdir -p $goprotocout

echo "Using protoc version" $(protoc --version), "protoc-gen-go version", $(protoc-gen-go --version)

cd $dir
for entry in $(find ./ -iname "*.proto"); do
    protoc --go_out=$goprotocout \
    --go_opt=paths=import \
    --go_opt=module=github.com/lutfipaper/module-proto/go \
    --go-grpc_out=$goprotocout \
    --go-grpc_opt=paths=import \
    --go-grpc_opt=module=github.com/lutfipaper/module-proto/go \
    $entry
    
done

for entry in $(find go/ -iname "*.go"); do
    protoc-go-inject-tag -input=$entry
    sed -i '/\/\/ versions:/d' $entry && sed -i '/\/\/ 	protoc/d' $entry
done

cd $dir
go mod tidy