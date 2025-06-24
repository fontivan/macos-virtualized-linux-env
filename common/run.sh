#!/usr/bin/env bash

set -eou pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# shellcheck disable=SC1091
source "${SCRIPT_DIR}/common.sh"

function run {
    local arch
    arch=$1

    local home_folder
    home_folder="/Users/$(whoami)"

    podman run \
        --pull=never \
        --privileged \
        -it \
        --rm \
        --workdir "/git" \
        -v "/var/run/docker.sock:/run/podman/podman.sock" \
        -v "${home_folder}/kubeconfigs:/kubeconfigs:Z" \
        -v "${home_folder}/.gitconfig:/root/.gitconfig:Z" \
        -v "${home_folder}/.gnupg/public-keys.d/pubring.db:/root/.gnupg/pubring.kbx:ro" \
        -v "${home_folder}/.gnupg/gpg.conf:/root/.gnupg/gpg.conf:ro" \
        -v "${home_folder}/.gnupg/private-keys-v1.d:/root/.gnupg/private-keys-v1.d:ro" \
        -v "${home_folder}/.ssh/id_rsa:/root/.ssh/id_rsa:ro" \
        -v "${home_folder}/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub:ro" \
        -v "${home_folder}/.zshrc:/root/.zshrc:ro" \
        -v "${home_folder}/.oh-my-zsh:/root/.oh-my-zsh:ro" \
        -v "${home_folder}/git:/git:Z" \
        "${TAG}-${arch}"
}

function main {
    check_os "$@"
    check_arg "$@"
    run "$@"
}

main "$@"
