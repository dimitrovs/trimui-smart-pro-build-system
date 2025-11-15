build:
	docker build -t trimui-smart-pro-build .

run:
	docker run --rm -it -v $(shell pwd):/workspace trimui-smart-pro-build

run-build: build run

.PHONY: build run run-build
