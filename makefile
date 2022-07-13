SHELL := /bin/bash # to enable source command in run_app

MODULE=weevenetwork/hash-to-int
VERSION_NAME=v1.0.0

install_dev:
	python3 -m pip install -r requirements_dev.txt
.phony: install_dev

lint:
	black src/ test/
	flake8 src/ test/
.phony: lint

run_app:
	set -a && source .env && set +a && python src/main.py
.phony: run_app

create_image:
	docker build -t ${MODULE}:${VERSION_NAME} . -f docker/Dockerfile
.phony: create_image

run_image:
	docker run -p 9090:9090 --rm --name sha256_to_integer --env-file=./.env ${MODULE}:${VERSION_NAME}
.phony: run_image

debug_image:
	docker run -p 9090:9090 --rm --name sha256_to_integer --env-file=./.env --entrypoint /bin/bash -it ${MODULE}:${VERSION_NAME}
.phony: debug_image

run_docker_compose:
	docker-compose -f docker/docker-compose.yml up
.phony: run_docker_compose

stop_docker_compose:
	docker-compose -f docker/docker-compose.yml down
.phony: stop_docker_compose

run_test:
	# For more verbose output you can add [-s] option
	pytest test/sha256_to_integer_test.py -v
.phony: run_test

push_latest:
	docker image push ${MODULE}:${VERSION_NAME}
.phony: push_latest

create_and_push_multi_platform:
	docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v6,linux/arm/v7 -t ${MODULE}:${VERSION_NAME} --push . -f docker/Dockerfile
.phony: create_and_push_multi_platform

