APPLICATION    := hyperkube
VERSION        := $(shell cat go.mod | grep k8s.io/kubectl | cut -d ' ' -f 3 | sed 's/v0./v1./')
.DEFAULT_GOAL := build-docker

.PHONY: build-docker
## build-docker: builds docker image to registry
build-docker:
	@echo "====> $@"
	docker build -t ${APPLICATION}:${VERSION} . --build-arg KUBERNETES_VERSION=${VERSION}

.PHONY: help
## help: prints this help message
help:
	@echo "Usage: \n"
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'
