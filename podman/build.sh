#!/usr/bin/env bash

set -eou pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "${SCRIPT_DIR}/common.sh"

function build {
    local arch
    arch=$1
    cd $SCRIPT_DIR
    podman build \
        --arch $arch \
        --build-arg ARCH="${arch}" \
        --build-arg OC_ARCH="$(echo ${arch} | sed 's/aarch64/arm64/')" \
        --build-arg SUBSCRIPTION_MANAGER_ORG="${SUBSCRIPTION_MANAGER_ORG}" \
        --build-arg SUBSCRIPTION_MANAGER_KEY="${SUBSCRIPTION_MANAGER_KEY}" \
        -t "${TAG}-${arch}" \
        .
}

function main {
    check_os $@
    check_arg $@
    build $@
}

main $@
