#!/usr/bin/env bash

set -eou pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# shellcheck disable=SC1091
source "${SCRIPT_DIR}/common.sh"

function main {
    check_os

    if [[ ! $(which brew) ]]; then
        echo "Brew must be available"
        exit 1
    fi

    brew install podman podman-desktop
    podman machine init --cpus 8 --memory 8192 --disk-size 100 --rootful podman-machine-default
    sudo /opt/homebrew/opt/podman/bin/podman-mac-helper install
    podman machine start

}

main
