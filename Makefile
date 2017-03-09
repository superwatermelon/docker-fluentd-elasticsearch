IMAGE_NAME := superwatermelon/fluentd-elasticsearch

# Usage:
#   make build
build:
	docker build --tag $(IMAGE_NAME) .

# Usage:
#   make test
test:
	IMAGE=$(IMAGE_NAME) bats test/suite.bats

.PHONY: test
