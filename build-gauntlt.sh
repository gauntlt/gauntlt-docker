#!/usr/bin/env bash

## Load variables file.  Defines which version we're using when downloading Arachni.
. arachni_vars

docker build \
  --pull=true \
  -t gauntlt \
  --build-arg=ARACHNI_RELEASE=${ARACHNI_RELEASE} \
  --build-arg=ARACHNI_VERSION=${ARACHNI_VERSION} \
  $( readlink -f $( pwd ) )
