FROM mycares/ros-noetic-gpu:latest

SHELL [ "/bin/bash", "-c" ]
WORKDIR /workspace

RUN pip install torch==1.13.1+cu116 torchvision==0.14.1+cu116 torchaudio==0.13.1 --extra-index-url https://download.pytorch.org/whl/cu116
RUN git clone https://github.com/facebookresearch/detectron2.git
RUN pip install -e detectron2
RUN pip install pyopenssl --upgrade
