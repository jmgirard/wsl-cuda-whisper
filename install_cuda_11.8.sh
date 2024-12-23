#!/bin/bash
# install_cuda_11.8.sh

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
    curl \
    ffmpeg \
    gnupg \
    libarchive-dev \
    software-properties-common

# Set up the NVIDIA CUDA repository for WSL Ubuntu
wget -nv https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pin
mv cuda-wsl-ubuntu.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget -nv https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda-repo-wsl-ubuntu-11-8-local_11.8.0-1_amd64.deb
dpkg -i cuda-repo-wsl-ubuntu-11-8-local_11.8.0-1_amd64.deb
cp /var/cuda-repo-wsl-ubuntu-11-8-local/cuda-*-keyring.gpg /usr/share/keyrings/

# Install CUDA Toolkit 11.8 for WSL Ubuntu
apt-get update
apt-get install -y cuda-toolkit-11-8

# Clean up
rm -rf /var/lib/apt/lists/* /cuda-repo-wsl-ubuntu-11-8-local_11.8.0-1_amd64.deb /tmp/*