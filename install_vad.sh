#!/bin/bash
# install_vad.sh

set -e

## Build ARGs
NCPUS=$(nproc || echo 1)

# Install R packages
install2.r --error --skipinstalled -n "$NCPUS" \
    abseil \
    audio \
    remotes \
    torch

# Install torch (requires CUDA 11.8)
R --no-save --no-restore -e "torch::install_torch()"

# Install VAD packages
R --no-save --no-restore -e "remotes::install_github('bnosac/audio.vadwebrtc')"
R --no-save --no-restore -e "remotes::install_github('bnosac/audio.vadsilero')"

# Clean up
rm -rf /tmp/*