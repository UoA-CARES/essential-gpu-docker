From gcr.io/kaggle-gpu-images/python

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    locales \
    lsb-release \
    git \
    nano \
    wget \
    curl \
    htop \
    libssl-dev \
    build-essential \
    software-properties-common && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

SHELL [ "/bin/bash", "-c" ]
WORKDIR /workspace

RUN pip install --upgrade setuptools pip
RUN pip install nvidia-pyindex
RUN pip install nvidia-tensorrt==7.2.3.4
RUN export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/conda/lib/python3.7/site-packages/tensorrt/
RUN echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/conda/lib/python3.7/site-packages/tensorrt/' >> /opt/conda/etc/conda/activate.d/env_vars.sh
RUN python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"