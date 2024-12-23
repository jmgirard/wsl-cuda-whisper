#!/bin/bash
# install_whisper.sh

set -e

AW_VERSION=${1:-${AW_VERSION}}

# Install audio.whisper
R -q -e '    
    pak::pkg_install("bnosac/audio.whisper@'${AW_VERSION}'")
    pak::cache_clean()
    pak::meta_clean(TRUE)
'
