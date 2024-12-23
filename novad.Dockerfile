ARG R_VERSION=4.4.2

FROM rocker/tidyverse:${R_VERSION}

COPY install_cuda_latest.sh install_openac.sh install_whisper.sh /setup_scripts/

RUN chmod +x /setup_scripts/*.sh 
RUN /setup_scripts/install_cuda_latest.sh
RUN /setup_scripts/install_openac.sh

ENV PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64
ENV CUDA_PATH=/usr/local/cuda
ENV WHISPER_CUBLAS=1
ENV AW_VERSION=0.4.1

ENTRYPOINT ["/bin/bash", "-c", "/setup_scripts/install_whisper.sh && exec /init"]