FROM rocker/tidyverse:4.4.1

ENV DEBIAN_FRONTEND=noninteractive

ENV PATH=/usr/local/cuda-12.6/bin${PATH:+:${PATH}}
ENV LD_LIBRARY_PATH=/usr/local/cuda-12.6/lib64
ENV CUDA_PATH=/usr/local/cuda-12.6
ENV CUDA=12.6
ENV WHISPER_CUBLAS=1

RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential wget curl gnupg ca-certificates software-properties-common ffmpeg \
    && wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-keyring_1.1-1_all.deb \
	&& sudo dpkg -i cuda-keyring_1.1-1_all.deb \
	&& sudo apt-get update \
	&& sudo apt-get -y install cuda-toolkit-12-6 \
    && R --no-save --no-restore -e "install.packages('remotes')" \
    && rm -rf /var/lib/apt/lists/* /tmp/*

CMD ["bash", "-c", "R --no-save --no-restore -e 'remotes::install_github(\"bnosac/audio.whisper\")' && exec /init"]
