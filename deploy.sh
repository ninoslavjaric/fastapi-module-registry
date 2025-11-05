#!/bin/bash

echo "Changing to script directory..."
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd $SCRIPT_DIR

echo "Loading environment variables from .env..."
# load env
source .env

echo "Building Docker image with PORT=$PORT..."
# build image
docker buildx build --build-arg PORT=$PORT -t fa --load .

docker images

if [ "${1:-}" = "test" ]; then
  echo "Running container and executing test.sh inside the container..."
  docker run -v /tmp/out:/tmp/out -p $PORT:$PORT --env-file .env -t fa test.sh
else
  echo "Running container without test.sh..."
  docker run -v /tmp/out:/tmp/out -p $PORT:$PORT --env-file .env -t fa
fi