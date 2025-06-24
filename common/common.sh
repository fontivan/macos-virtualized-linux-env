#!/usr/bin/env bash

TAG="${TAG-localhost/macos-virtualized-linux-env}"
LINUX_ENV="${LINUX_ENV-linux}"

function check_arg {
    if [[ $# -eq 0 ]]; then
        echo "\$1 must be 'amd64' or 'aarch64'"
        exit 1
    fi

    local arch
    arch=$1
    if [[ "${arch}" == "amd64" || "${arch}" == "aarch64" ]]; then
        echo "Creating '${LINUX_ENV}' env using arch '${arch}'"
        return 0
    else
        echo "\$1 must be 'amd64' or 'aarch64'"
        exit 1
    fi
}

function check_os {
    if [[ $(uname) != 'Darwin' ]]; then
        echo "Only for macOS"
        exit 1
    fi
}

