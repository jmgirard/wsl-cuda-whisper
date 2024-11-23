#!/bin/bash
# install_cuda_latest.sh

set -e

# A function to install apt packages only if they are not installed
function apt_install() {
    if ! dpkg -s "$@" >/dev/null 2>&1; then
        if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
            apt-get update
        fi
        apt-get install -y --no-install-recommends "$@"
    fi
}

# Install apt dependencies
apt_install \
    build-essential \
    ca-certificates \
    curl \
    ffmpeg \
    git \
    gnupg \
    software-properties-common \
    wget

# Set up the NVIDIA CUDA repository for WSL Ubuntu
wget -nv https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-keyring_1.1-1_all.deb
dpkg -i cuda-keyring_1.1-1_all.deb

# Install CUDA Toolkit
apt-get update
apt_install cuda-toolkit

# Clean up
rm -rf /var/lib/apt/lists/* cuda-keyring_1.1-1_all.deb /tmp/*