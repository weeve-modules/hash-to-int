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
	docker build -t $(ACCOUNT_NAME)/$(MODULE_NAME) . -f Dockerfile

dev:
	nodemon main.py

run: ## Run container on port configured in `config.env`
	docker run --rm \
		-e EGRESS_API_HOST=$(EGRESS_HOST_PATH):$(EGRESS_PORT) \
		-e MODULE_NAME=$(MODULE_NAME) \
		$(ACCOUNT_NAME)/$(MODULE_NAME)

# docker run -it --rm --env-file=./config.env $(ACCOUNT_NAME)/$(APP_NAME)
# run_image:
# 	docker run -p 8000:5000 --rm boilerplate:latest
# .phony: run_image

lint:
	pylint main.py app/
.phony: lint

install_local:
	pip3 install -r requirements.txt
.phony: install_local

listentest: ## Run a listener container and receive messages from this container
	docker network create $(NETWORK_NAME) || true
	docker run --detach --network=$(NETWORK_NAME) --rm \
		-e PORT=8000 \
		-e LOG_HTTP_BODY=true \
		-e LOG_HTTP_HEADERS=true \
		--name echo jmalloc/echo-server
	docker run --rm \
		--network=$(NETWORK_NAME)
		-e EGRESS_API_HOST=$(EGRESS_HOST_PATH):$(EGRESS_PORT) \
		$(ACCOUNT_NAME)/$(MODULE_NAME)
	docker run \
		--network=$(NETWORK_NAME) --rm \
		-e EGRESS_API_HOST=$(EGRESS_HOST_PATH):$(EGRESS_PORT)
		$(ACCOUNT_NAME)/$(APP_NAME)

run_local:
	 python main.py
.phony: run_local
