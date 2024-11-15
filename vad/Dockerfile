FROM rocker/tidyverse:4.4.1

ENV DEBIAN_FRONTEND=noninteractive

ENV PATH=/usr/local/cuda-11.8/bin${PATH:+:${PATH}}
ENV LD_LIBRARY_PATH=/usr/local/cuda-11.8/lib64
ENV CUDA_PATH=/usr/local/cuda-11.8
ENV CUDA=11.8
ENV WHISPER_CUBLAS=1

RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential wget curl gnupg ca-certificates software-properties-common ffmpeg \
    && wget -nv https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pin \
    && mv cuda-wsl-ubuntu.pin /etc/apt/preferences.d/cuda-repository-pin-600 \
    && wget -nv https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda-repo-wsl-ubuntu-11-8-local_11.8.0-1_amd64.deb \
    && dpkg -i cuda-repo-wsl-ubuntu-11-8-local_11.8.0-1_amd64.deb \
    && cp /var/cuda-repo-wsl-ubuntu-11-8-local/cuda-*-keyring.gpg /usr/share/keyrings/ \
    && apt-get update \
    && apt-get install -y cuda-toolkit-11-8 \
    && R --no-save --no-restore -e "install.packages(c('remotes', 'audio', 'abseil', 'torch'))" \
    && R --no-save --no-restore -e "torch::install_torch()" \
    && R --no-save --no-restore -e "remotes::install_github('bnosac/audio.vadwebrtc')" \
    && R --no-save --no-restore -e "remotes::install_github('bnosac/audio.vadsilero')" \
    && rm -rf /var/lib/apt/lists/* /cuda-repo-wsl-ubuntu-11-8-local_11.8.0-1_amd64.deb /tmp/*

CMD ["bash", "-c", "R --no-save --no-restore -e 'remotes::install_github(\"bnosac/audio.whisper\")' && exec /init"]
