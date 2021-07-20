#!/bin/bash
set -eo pipefail

# use these envvars to override:
DOCKER_COMMAND="${DOCKER_COMMAND:-docker}"
IMAGE_REPO="${IMAGE_REPO:-quay.io/opendatahub/traefik}"
IMAGE_TAG="${IMAGE_TAG:-dev}"

set -ux

$DOCKER_COMMAND build -t "$IMAGE_REPO:$IMAGE_TAG" .
