#!/usr/bin/env bash

set -eou pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "${SCRIPT_DIR}/../common/common.sh"

TAG="localhost/macos-virtualized-ubi-env"

# These must be passed as environment variables to the script
SUBSCRIPTION_MANAGER_ORG=${SUBSCRIPTION_MANAGER_ORG-}
SUBSCRIPTION_MANAGER_KEY=${SUBSCRIPTION_MANAGER_KEY-}

function check_subscription {
    if [[ -z "${SUBSCRIPTION_MANAGER_ORG}" ]];
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
