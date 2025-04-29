#!/usr/bin/env bash

set -eou pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "${SCRIPT_DIR}/common.sh"

function run {
    local arch
    arch=$1
    podman run \
        --privileged \
        -it \
        --rm \
        --arch "${arch}" \
        --workdir "/git" \
        -v "/var/run/docker.sock:/run/podman/podman.sock" \
        -v "/Users/$(whoami)/kubeconfigs:/kubeconfigs:Z" \
        -v "/Users/$(whoami)/.gitconfig:/root/.gitconfig:Z" \
        -v "/Users/$(whoami)/.gnupg/pubring.kbx:/root/.gnupg/pubring.kbx:ro" \
        -v "/Users/$(whoami)/.gnupg/gpg.conf:/root/.gnupg/gpg.conf:ro" \
        -v "/Users/$(whoami)/.gnupg/private-keys-v1.d:/root/.gnupg/private-keys-v1.d:ro" \
        -v "/Users/$(whoami)/.ssh/id_rsa:/root/.ssh/id_rsa:ro" \
        -v "/Users/$(whoami)/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub:ro" \
        -v "/Users/$(whoami)/.zshrc:/root/.zshrc:ro" \
        -v "/Users/$(whoami)/.oh-my-zsh:/root/.oh-my-zsh:ro" \
        -v "/Users/$(whoami)/git:/git:Z" \
        -t "${TAG}-${arch}"
}

function main {
    check_os $@
    check_arg $@
    run $@
}

main $@
