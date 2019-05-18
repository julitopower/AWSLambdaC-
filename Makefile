ROOT="$(shell cd "$(dirname "$0")" ; pwd -P)"
BUILD_IMG="aws_cpp_lambda_build_img" 
NAME="build"

all: docker build

.PHONY: build dev docker

# Target to build the docker images
docker:
	docker build -t ${BUILD_IMG} .

# Target to build the labmda functions
build:
	docker run --rm -v ${ROOT}:/opt/src/ --name ${NAME} ${BUILD_IMG} \
	scripts/build.sh

# Target to log into the development container
dev:
	docker run -it --rm -v ${ROOT}:/opt/src ${BUILD_IMG} /bin/bash
