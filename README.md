# macos-virtualized-linux-env

Build and run RHEL containers on macOS using both amd64 and arm64 environments.

This is great for running code compiles without having to deal with macOS environment being different from Linux.

## Setup

The script `common/setup.sh` should contain the necessary setup. It requires brew, and will automatically install and configure podman.

## Build

You can build a container environment by passing an architecture to the script.

A valid RHEL subscription is required to complete the ubi container build.

```bash
# To build an amd64 container:
SUBSCRIPTION_MANAGER_ORG="my-org-id" SUBSCRIPTION_MANAGER_KEY="my-key-id" /path/to/checkout/macos-virtualized-linux-env/ubi/build.sh amd64

# To build an aarch64 container:
SUBSCRIPTION_MANAGER_ORG="my-org-id" SUBSCRIPTION_MANAGER_KEY="my-key-id" /path/to/checkout/macos-virtualized-linux-env/ubi/build.sh aarch64

# To build an amd64 debian container:
/path/to/checkout/macos-virtualized-linux-env/debian/build.sh amd64

# To build an aarch64 debian container:
/path/to/checkout/macos-virtualized-linux-env/debian/build.sh aarch64
```

## Run

You can start a new environment using the run script:

```bash
# To run an amd64 ubi container:
/path/to/checkout/macos-virtualized-linux-env/ubi/run.sh amd64

# To build an aarch64 ubi container:
/path/to/checkout/macos-virtualized-linux-env/ubi/run.sh aarch64

# To run an amd64 debian container:
/path/to/checkout/macos-virtualized-linux-env/debian/run.sh amd64

# To build an aarch64 debian container:
/path/to/checkout/macos-virtualized-linux-env/debian/run.sh aarch64
```

The script will automatically mount both `~/git` and `~/.ssh` to the running container.
The script will also automatically mount the docker socket into the container where you can use `podman-remote` to run podman commands and builds inside the container.

