FROM mycares/ros-noetic-gpu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libx11-dev \
    libxt-dev \
    libimlib2-dev \
    libxinerama-dev \
    libjpeg-progs && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

SHELL [ "/bin/bash", "-c" ]
WORKDIR /

RUN git clone https://git.finalrewind.org/feh && \
    cd feh && \
    make && \
    make install && \
    cd ..

RUN pip install torch==1.13.1+cu116 torchvision==0.14.1+cu116 torchaudio==0.13.1 --extra-index-url https://download.pytorch.org/whl/cu116
RUN git clone https://github.com/facebookresearch/detectron2.git
RUN pip install -e detectron2
RUN pip install pyopenssl --upgrade

COPY dockers/assets/input.jpg /detectron2/demo

WORKDIR /workspace