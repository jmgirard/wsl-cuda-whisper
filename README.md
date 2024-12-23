# wsl-cuda-whisper
The audio.whisper R package allows users to easily use OpenAI's Whisper model (e.g., for automated transcription of audio files) from R. Significant speedups can be achieved on machines with CUDA-enabled graphics cards, but setting this up can be complicated. This docker image allows a user on Windows to easily install all the dependencies needed to run audio.whisper with CUDA support via Windows Subsystem for Linux (WSL2). It is built on top of the rocker/tidyverse image, which means it comes with RStudio Server installed.

| Tag    | Base Image       | Operating System | R ver | CUDA ver |
|--------|------------------|------------------|-------|----------|
| latest | rocker/tidyverse | Ubuntu 24.04 LTS | 4.4.2 | 12.6     |
| novad  | rocker/tidyverse | Ubuntu 24.04 LTS | 4.4.2 | 11.8     |
| vad    | rocker/tidyverse | Ubuntu 22.04 LTS | 4.4.1 | 11.8     |

Usage:
1. Verify that your machine's graphics card supports CUDA: https://developer.nvidia.com/cuda-gpus
2. On Windows, install the latest game-ready driver from NVIDIA: https://www.nvidia.com/Download/index.aspx#
3. On Windows, install the latest version of Docker Desktop: https://www.docker.com/products/docker-desktop/
4. Open Docker Desktop and click the Terminal button on the bottom of the screen
5. In the Terminal, type `docker pull jmgirard/wsl-cuda-whisper:vad` or `docker pull jmgirard/wsl-cuda-whisper:novad` 
6. In the Terminal, type `docker run --gpus all -it -e PASSWORD=pass -p 8787:8787 jmgirard/wsl-cuda-whisper`
7. Once the Terminal has a line beginning with "TTY detected.", the container is ready
6. In Docker Desktop, click the Containers tab on the left and click the "8787:8787" link
9. Your browser should show a login page, enter "rstudio" as the username and "pass" for the password
10. You should now be shown the RStudio page, so enter `library(audio.whisper)` 
11. Now you can download and load whisper models via, e.g., `model <- whisper("tiny", use_gpu = TRUE)`
12. You can now use the `model` object and the `predict()` function with great speed
