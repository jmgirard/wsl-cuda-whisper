#!/bin/bash
# install_openac.sh

set -e

# Build ARGs
NCPUS=$(nproc || echo 1)

# Install pak and use it to install openac
R -q -e '    
    options(mc.cores = '${NCPUS}')
    install.packages("pak", repos = sprintf("https://r-lib.github.io/p/pak/stable/%s/%s/%s", .Platform$pkgType, R.Version()$os, R.Version()$arch))
    remotes::install_github("jmgirard/openac")
'
