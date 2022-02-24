# import config.
# You can change the default config with `make cnf="config_special.env" build`
cnf ?= config.env
include $(cnf)
export $(shell sed 's/=.*//' $(cnf))

# import deploy config
# You can change the default deploy config with `make cnf="deploy_special.env" release`
dpl ?= deploy.env
include $(dpl)
export $(shell sed 's/=.*//' $(dpl))

# # grep the version from the mix file
# VERSION=$(shell ./version.sh)

# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

# create_image:
# 	docker build -t boilerplate .
# .phony: create_image

build: ## Build the container
	docker build -t $(ACCOUNT_NAME)/$(MODULE_NAME):$(VERSION_TAG) . -f image/Dockerfile

dev:
	nodemon main.py

listen: ## Pull and start a listener
	docker run --detach \
		-e PORT=$(LISTEN_PORT) \
		-e LOG_HTTP_BODY=true \
		-e LOG_HTTP_HEADERS=true \
		-p $(LISTEN_PORT):$(LISTEN_PORT) \
		--name echo jmalloc/echo-server

run: ## Run container on port configured in `config.env`
	docker run --rm --env-file=./config.env \
		--network=dtestnet \
		-p $(INGRESS_PORT)\:$(INGRESS_PORT) \
		--name $(MODULE_NAME) \
		$(ACCOUNT_NAME)/$(MODULE_NAME)

# docker run -it --rm --env-file=./config.env $(ACCOUNT_NAME)/$(MODULE_NAME)
# run_image:
# 	docker run -p 8000:5000 --rm boilerplate:latest
# .phony: run_image

# lint:
# 	pylint main.py app/
# .phony: lint

# install_local:
# 	pip3 install -r ./image/requirements.txt
# .phony: install_local

# curltest: ## Send sample data to the
# 	curl --header "Content-Type: application/json" \
# 		--request POST \
# 		--data '{"random hash"\:"f36940fb3203f6e1b232f84eb3f796049c9cf1761a9297845e5f2453eb036f01"}' \
# 		localhost:$(INGRESS_PORT)

listentest: ## Run a listener container and receive messages from this container
	make build
	docker network create $(NETWORK_NAME) || true
	echo "Starting listener container"
	docker run --detach --rm \
		--network=$(NETWORK_NAME) \
		-e PORT=$(LISTEN_PORT)  \
		-e LOG_HTTP_BODY=true \
		-e LOG_HTTP_HEADERS=true \
		--name echo \
		jmalloc/echo-server
	echo "Starting module container"
	docker run --detach --rm --env-file=./config.env \
		--network=$(NETWORK_NAME) \
		-p $(INGRESS_PORT):$(INGRESS_PORT) \
		--name $(MODULE_NAME) \
		$(ACCOUNT_NAME)/$(MODULE_NAME):$(VERSION_TAG)
	echo "Waiting for 2 seconds..."
	sleep 2
	echo "Sending test payload"
	curl --header "Content-Type: application/json" \
		--request POST \
		--data '{"random hash":"f36940fb3203f6e1b232f84eb3f796049c9cf1761a9297845e5f2453eb036f01"}' \
		localhost:$(INGRESS_PORT)
	echo "Result as seen in listener:"
	docker logs echo
	echo "Cleanup"
	docker container stop echo $(MODULE_NAME)
	docker network rm $(NETWORK_NAME)
	echo "Test done."

clean:
	docker container stop echo $(MODULE_NAME)
	docker container rm echo $(MODULE_NAME)

run_local:
	 python3 ./image/src/main.py
.phony: run_local

push: ## Push to dockerhub, needs credentials!
	docker push $(ACCOUNT_NAME)/$(MODULE_NAME):$(VERSION_TAG)

pushrm: ## Push to dockerhub AND add description, needs additionally the pushrm tool!
## https://github.com/christian-korneck/docker-pushrm
	docker push $(ACCOUNT_NAME)/$(MODULE_NAME):$(VERSION_TAG)
	docker pushrm $(ACCOUNT_NAME)/$(MODULE_NAME):$(VERSION_TAG) --short $(DESCRIPTION)

build_and_push_multi_platform:
	echo "Building multi platform image"
	echo $(ACCOUNT_NAME)/$(MODULE_NAME)
	docker buildx build --platform linux/amd64,linux/arm,linux/arm64 -t $(ACCOUNT_NAME)/$(MODULE_NAME) --push . -f image/Dockerfile
.phony: create_and_push_multi_platform