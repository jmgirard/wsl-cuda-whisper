#!/bin/bash
# install_vad.sh

set -e

## Build ARGs
NCPUS=$(nproc || echo 1)

# Install R packages and cleanup
R -q -e '
    options(mc.cores = '${NCPUS}')
    install.packages("pak", repos = sprintf("https://r-lib.github.io/p/pak/stable/%s/%s/%s", .Platform$pkgType, R.Version()$os, R.Version()$arch))
    pak::pkg_install(c("abseil", "bnosac/audio.vadwebrtc", "bnosac/audio.vadsilero", "torch"))
    torch::install_torch()
    pak::cache_clean()
    pak::meta_clean(TRUE)
'

# Clean up
rm -rf /tmp/*