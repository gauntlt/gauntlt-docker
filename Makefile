all: help

build:
	@echo "Building docker container..."
	@./build-gauntlt.sh

build-dev:
	@echo "Building docker development container..."
	@docker build -f Dockerfile-dev -t gauntlt-dev .

clean:
	@echo "Removing unused docker containers..."
	@./docker-clean.sh

clean-all: clean
	@echo "Removing gauntlt image..."
	@docker rmi gauntlt

interactive:
	@docker run --rm -it --entrypoint /bin/bash gauntlt

install-stub:
	@echo "installing gauntlt-docker to /usr/local/bin"
	@cp ./bin/gauntlt-docker /usr/local/bin

runexamples:
	@echo "Running all examples"
	@docker run --rm -it -v  ${CURDIR}/examples:/attacks gauntlt
help:
	@echo "the help menu"
	@echo "  make build"
	@echo "  make build-dev"
	@echo "  make clean"
	@echo "  make clean-all"
	@echo "  make help"
	@echo "  make install-stub"
	@echo "  make interactive"
	@echo "  make runexamples"

.PHONY: build clean
