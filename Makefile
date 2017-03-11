IMAGE_NAME := superwatermelon/fluentd-elasticsearch
tag := $(if $(TAG),$(TAG),test)

# Usage:
#   make build [TAG=]
image:
	docker build --tag $(IMAGE_NAME):$(tag) .

# Usage:
#   make test [TAG=]
test:
	IMAGE=$(IMAGE_NAME):$(tag) bats test/suite.bats

# Usage:
#   make release [TAG=]
release:
	docker build --tag $(IMAGE_NAME):$(tag) .
	docker tag $(IMAGE_NAME):$(tag) $(IMAGE_NAME):latest
	scripts/docker-login
	docker push $(IMAGE_NAME):$(tag)
	docker push $(IMAGE_NAME):latest

.PHONY: test
