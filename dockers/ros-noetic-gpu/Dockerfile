FROM osrf/ros:noetic-desktop-full

RUN apt-get update && apt-get install -y \
    lsb-release \
    build-essential \
    pip \
    git \
    apt-utils \
    wget \
    curl \
    nano && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

SHELL [ "/bin/bash", "-c" ]
WORKDIR /workspace

RUN echo "source /opt/ros/noetic/setup.bash" >> /root/.bashrc







