#!/bin/bash
# install_whisper.sh

# Install the previously downloaded package
R -q -e 'remotes::install_local("/home/rstudio/audio.whisper")'

# Cleanup
rm -rf /home/rstudio/audio.whisper