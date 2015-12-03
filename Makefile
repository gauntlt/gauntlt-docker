all: help

build:
	@echo "Building docker container..."
	@./build-gauntlt.sh

clean:
	@echo "Removing unused docker containers..."
	@./docker-clean.sh

install:
	@echo "installing gauntlt-docker to /usr/local/bin"
	@cp ./bin/gauntlt-docker /usr/local/bin

help:
	@echo "the help menu"
	@echo "  make clean"
	@echo "  make build"
	@echo "  make help"

.PHONY: build clean
