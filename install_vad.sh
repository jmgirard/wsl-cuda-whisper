#!/bin/bash
# install_vad.sh

set -e

# Install R packages and cleanup
R -q -e '
    pak::pkg_install(c("abseil", "bnosac/audio.vadwebrtc", "bnosac/audio.vadsilero", "torch"))
    torch::install_torch()
    pak::cache_clean()
    pak::meta_clean(TRUE)
'

# Clean up
rm -rf /tmp/*