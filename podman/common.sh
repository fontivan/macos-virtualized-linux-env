#!/usr/bin/env bash

TAG="localhost/macos-virtualized-linux-env"

# These must be passed as environment variables to the script
SUBSCRIPTION_MANAGER_ORG=${SUBSCRIPTION_MANAGER_ORG-}
SUBSCRIPTION_MANAGER_KEY=${SUBSCRIPTION_MANAGER_KEY-}

function check_arg {
    if [[ $# -eq 0 ]];
    then
        echo "\$1 must be 'amd64' or 'aarch64'"
        exit 1
    fi

    local arch
    arch=$1
    if [[ "${arch}" == "amd64" || "${arch}" == "aarch64" ]];
    then
        echo "Creating UBI env using arch '$arch'"
        return 0
    else
        echo "\$1 must be 'amd64' or 'aarch64'"
        exit 1
    fi

    if [[ -z "${SUBSCIPTION_MANAGER_ORG}" ]];
    then
        echo "'SUBSCRIPTION_MANAGER_ORG' must be set in env"
        exit 1
    fi

    if [[ -z "${SUBSCRIPTION_MANAGER_KEY}" ]];
    then
        echo "'SUBSCRIPTION_MANAGER_KEY' must be set in env"
        exit 1
    fi
}

function check_os {
    if [[ $(uname) != 'Darwin' ]];
    then
        echo "Only for macOS"
        exit 1
    fi
}
