# macos-virtualized-linux-env

Build and run RHEL containers on macOS using both amd64 and arm64 environments.

This is great for running code compiles without having to deal with macOS environment being different from Linux.

## Setup

The script `podman/setup.sh` should contain the necessary setup. It requires brew, and will automatically install and configure podman.

## Build

You can build a container environment by passing an architecture to the script. You will also need to provide a subscription manager key and organization since the Containerfile uses RHEL.

```bash
# To build an amd64 container:
SUBSCRIPTION_MANAGER_ORG="my-org-id" SUBSCRIPTION_MANAGER_KEY="my-key-id" /path/to/checkout/macos-virtualized-linux-env/podman/build.sh amd64

# To build an amd64 container:
SUBSCRIPTION_MANAGER_ORG="my-org-id" SUBSCRIPTION_MANAGER_KEY="my-key-id" /path/to/checkout/macos-virtualized-linux-env/podman/build.sh aarch64
```

## Run

You can start a new environment using the run script:

```bash
# To run an amd64 container:
/path/to/checkout/macos-virtualized-linux-env/podman/run.sh amd64

# To build an amd64 container:
/path/to/checkout/macos-virtualized-linux-env/podman/run.sh aarch64
```

The script will automatically mount both `~/git` and `~/.ssh` to the running container.
The script will also automatically mount the docker socket into the container where you can use `podman-remote` to run podman commands and builds inside the container.

