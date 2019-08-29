#!/usr/bin/env bash

set -o errexit -o nounset

image_repository="thulioassis/bazel-docker-image"
latest_bazel_url="https://api.github.com/repos/bazelbuild/bazel/releases/latest"
docker_hub_url="https://hub.docker.com/v2/repositories"

version=$(curl "${latest_bazel_url}" 2> /dev/null | awk 'match($0, /"tag_name": "(.*)"/, cg) { print cg[1] }')

echo "${image_repository}:${version}" > "${IMAGE_FILE}"
echo "${version}" > "${VERSION_FILE}"
