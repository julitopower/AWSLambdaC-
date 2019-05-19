#!/bin/bash
ROOT="/opt/src/"

cd ${ROOT}
mkdir -p build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=/usr/local/
make
make aws-lambda-package-juliod_cpp_aws_lambda
