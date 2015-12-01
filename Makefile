all: help

build:
	@./build-gauntlt.sh

clean:
	@./docker-clean.sh	

help:
	@echo "the help menu"
	@echo "make clean"
	@echo "make build"
	@echo "make help"

.PHONY: build clean
