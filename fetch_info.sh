#!/usr/bin/env bash

set -o errexit -o nounset

latest_bazel_url="https://api.github.com/repos/bazelbuild/bazel/releases/latest"
version=$(curl "${latest_bazel_url}" 2> /dev/null | awk 'match($0, /"tag_name": "(.*)"/, cg) { print cg[1] }')
echo "${version}" > "${VERSION_FILE}"
