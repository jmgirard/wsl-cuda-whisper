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
    gnupg \
    libarchive-dev \
    software-properties-common \
    wget

# Set up the NVIDIA CUDA repository for WSL Ubuntu
wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pin
mv cuda-wsl-ubuntu.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/12.6.3/local_installers/cuda-repo-wsl-ubuntu-12-6-local_12.6.3-1_amd64.deb
dpkg -i cuda-repo-wsl-ubuntu-12-6-local_12.6.3-1_amd64.deb
cp /var/cuda-repo-wsl-ubuntu-12-6-local/cuda-*-keyring.gpg /usr/share/keyrings/

# Install CUDA Toolkit 12.6 for WSL Ubuntu
apt-get update
apt_install cuda-toolkit-12-6

# Clean up
rm -rf /var/lib/apt/lists/* /cuda-repo-wsl-ubuntu-12-6-local_12.6.3-1_amd64.deb /tmp/*