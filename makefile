SHELL := /bin/bash

create_image:
	docker build -t boilerplate .
.phony: create_image

run_image:
	docker run -p 8000:5000 --rm boilerplate:latest
.phony: run_image

lint:
	pylint main.py app/
.phony: lint

install_local:
	pip3 install -r requirements.txt
.phony: install_local

run_local:
	 python main.py
.phony: run_local
