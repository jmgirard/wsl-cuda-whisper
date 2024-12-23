ARG R_VERSION=4.4.2

FROM rocker/tidyverse:${R_VERSION}

COPY install_cuda_12.6.sh install_openac.sh install_whisper.sh /setup_scripts/

RUN chmod +x /setup_scripts/*.sh 
RUN /setup_scripts/install_cuda_12.6.sh
RUN /setup_scripts/install_openac.sh

ENV PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64
ENV CUDA_PATH=/usr/local/cuda
ENV WHISPER_CUBLAS=1
ENV AW_VERSION=master

ENTRYPOINT ["/bin/bash", "-c", "/setup_scripts/install_whisper.sh && exec /init"]