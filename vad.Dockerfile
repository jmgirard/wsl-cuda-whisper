ARG R_VERSION=4.4.1

FROM rocker/tidyverse:${R_VERSION}

COPY install_cuda_11.8.sh install_openac.sh install_vad.sh install_whisper.sh /setup_scripts/

RUN chmod +x /setup_scripts/*.sh
RUN /setup_scripts/install_cuda_11.8.sh
RUN /setup_scripts/install_openac.sh
RUN /setup_scripts/install_vad.sh

ENV PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64
ENV CUDA_PATH=/usr/local/cuda
ENV WHISPER_CUBLAS=1
ENV AW_VERSION=0.4.1

ENTRYPOINT ["/bin/bash", "-c", "/setup_scripts/install_whisper.sh && exec /init"]