ARG R_VERSION=4.4.1

FROM rocker/tidyverse:${R_VERSION}

COPY install_cuda_11.8.sh /rocker_scripts/install_cuda_11.8.sh
COPY install_vad.sh /rocker_scripts/install_vad.sh

RUN /rocker_scripts/install_cuda_11.8.sh && /rocker_scripts/install_vad.sh

ENV PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64
ENV CUDA_PATH=/usr/local/cuda
ENV WHISPER_CUBLAS=1

CMD ["bash", "-c", "R --no-save --no-restore -e 'remotes::install_github(\"bnosac/audio.whisper\")' && exec /init"]
