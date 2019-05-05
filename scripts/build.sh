#!/bin/bash
ROOT="/opt/src/"

cd ${ROOT}
mkdir -p build
cd build
cmake ..
make
make aws-lambda-package-juliod_cpp_aws_lambda
