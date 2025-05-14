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
