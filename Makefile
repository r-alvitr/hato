SHELL := /usr/bin/env bash
NAME = hato

.PHONY: build
build:
	$(if $(shell command -v podman), \
		podman build . -t ${NAME} \
		, \
		sudo docker build . -t ${NAME} \
	)

.PHONY: run
run:
	$(if $(shell command -v podman), \
		podman run --name $@ -p 22:22 -it ${NAME} \
		, \
		sudo docker run --name $@ -p 22:22 -it ${NAME} \
	)
