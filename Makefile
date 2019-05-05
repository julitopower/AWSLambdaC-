ROOT="$(shell cd "$(dirname "$0")" ; pwd -P)"
BUILD_IMG="build_img" 
NAME="build"

all: build

.PHONY: build dev

build:
	docker run --rm -v ${ROOT}:/opt/src/ --name ${NAME} ${BUILD_IMG} \
	scripts/build.sh

dev:
	docker run -it --rm -v ${ROOT}:/opt/src ${BUILD_IMG} /bin/bash
