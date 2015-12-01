#!/bin/bash

set -e

function build() {
  local TARGET=$1
  if [ ! -d $TARGET ]; then
    echo "** ERROR: $TARGET isn't a valid directory"
  fi
  docker build -t $TARGET .
}

build "gauntlt"
