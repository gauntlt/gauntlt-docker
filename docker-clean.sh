#!/usr/bin/env bash

function docker-cleanup {
  EXITED=$(docker ps -aq -f status=exited)
  DANGLING=$(docker images -q -f "dangling=true")

  if [ "$1" == "--dry-run" ]; then
    echo "==> Would stop containers:"
    echo $EXITED
    echo "==> And images:"
    echo $DANGLING
  else
    if [ -n "$EXITED" ]; then
      echo "Removing these containers:"
      docker rm $EXITED
    else
      echo "No containers to remove."
    fi
    if [ -n "$DANGLING" ]; then
      echo "Removing these images:"
      docker rmi $DANGLING
    else
      echo "No images to remove."
    fi
  fi
}

# use --dry-run to see what would happen

docker-cleanup
