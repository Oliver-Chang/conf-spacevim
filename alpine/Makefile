NS ?= oliver
VERSION ?= latest
IMAGE_NAME ?= dnvim

.PHONY: build push release

build: Dockerfile
	docker build -t $(NS)/$(IMAGE_NAME):$(VERSION) -f Dockerfile .

push:
	docker push $(NS)/$(IMAGE_NAME):$(VERSION)
release: build
	make push -e VERSION=$(VERSION)

default: build
