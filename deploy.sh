#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

cd $SCRIPT_DIR

# load env
source .env

# build image
docker buildx build --build-arg PORT=$PORT -t fa .

# If first argument is 'test', run container and execute test.sh inside the container.
# Otherwise run container without passing test.sh.
if [ "${1:-}" = "test" ]; then
  docker run -v /tmp/out:/tmp/out -p $PORT:$PORT --env-file .env -t fa test.sh
else
  docker run -v /tmp/out:/tmp/out -p $PORT:$PORT --env-file .env -t fa
fi