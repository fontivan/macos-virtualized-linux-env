#!/usr/bin/env bash

set -eou pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# shellcheck disable=SC1091
source "${SCRIPT_DIR}/common.sh"

function main {
    check_os "$@"
    check_arg "$@"
    run "$@"
}

main "$@"
