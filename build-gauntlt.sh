#!/bin/bash

set -e

function build() {
  local TARGET=$1
  docker build -t $TARGET .
}

build "gauntlt"
