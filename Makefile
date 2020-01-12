SHELL := /usr/bin/env bash
NAME = hato

build:
	$(if $(shell command -v podman), \
		podman build . -t ${NAME} \
		, \
		sudo docker build . -t ${NAME} \
	)

run:
	$(if $(shell command -v podman), \
		podman run --name $@ --publish 22:22 ${NAME} \
		, \
		sudo docker run -it --name $@ -p 22:22 ${NAME} \
	)
