ARG R_VERSION=4.4.1

FROM rocker/tidyverse:${R_VERSION}

COPY install_cuda_11.8.sh install_vad.sh download_whisper.sh install_whisper.sh /setup_scripts/

RUN chmod +x /setup_scripts/*.sh \
    && /setup_scripts/install_cuda_11.8.sh \
    && /setup_scripts/install_vad.sh \
    && /setup_scripts/download_whisper.sh

ENV PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64
ENV CUDA_PATH=/usr/local/cuda
ENV WHISPER_CUBLAS=1

CMD ["/init"]