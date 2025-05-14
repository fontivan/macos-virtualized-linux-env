#!/usr/bin/env bash

set -eou pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# shellcheck disable=SC1091
source "${SCRIPT_DIR}/debian.sh"

function build {
    local arch
    arch=$1
    (
        cd "${SCRIPT_DIR}/../"
        # shellcheck disable=SC2001,SC2086
        podman build \
            --arch ${arch} \
            --build-arg AMD64_AARCH64_ARCH="${arch}" \
            --build-arg AMD64_ARM64_ARCH="$(echo ${arch} | sed 's/aarch64/arm64/')" \
            -t "${TAG}-${arch}" \
            -f ./debian/Containerfile \
            .
    )
}

function main {
    check_os "$@"
    check_arg "$@"
    build "$@"
}

main "$@"
