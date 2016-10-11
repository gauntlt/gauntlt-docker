gauntlt () {
  ## Assumes container has been built using Dockerfile in this repo
  local DOCKER_IMAGE="gauntlt"
  local COMMAND="docker run -it --rm --name gauntlt -v $( readlink -f $( pwd ) ):/working"
  local ARGS="${@}"

  ## Allow entering the container to test by hand
  case "${1}" in
    debug)
      COMMAND="${COMMAND} --entrypoint=/bin/bash --user=root"
      unset ARGS
    ;;
  esac

  _check_docker_sock_perms
  _check_docker_image_installed "${DOCKER_IMAGE}"

  ${COMMAND} ${DOCKER_IMAGE} ${ARGS}
}
