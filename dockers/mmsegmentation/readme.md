### Prerequisites
[Install Nvidia Docker](https://github.com/UoA-CARES/essential-gpu-docker/blob/main/ADMINISTRATOR.md#install-nvidia-docker)
```
sudo apt update && sudo apt install -y build-essential
```

### Build 
```
cd PATH_TO_ESSENTIAL_GPU_DOCKER
make mmseg
```

### Run
To access all the code in your local workspace, use the '-v $HOME/workspace:/workspace' option to mount your workspace to the container(replace '$HOME/workspace' with your workspace path). The container's default user is 'root', so avoid modifying any files in the container and use it only for training purposes. 

```
docker run -it --rm \
    --privileged \
    --gpus all \
    --runtime=nvidia \
    --device=/dev/dri:/dev/dri \
    -e NVIDIA_VISIBLE_DEVICES=all \
    -e NVIDIA_DRIVER_COMPABILITIES=all \
    -e QT_X11_NO_MITSHM=1 \
    -e DISPLAY=$DISPLAY \
    -v /dev/shm:/dev/shm \
    -v "/tmp/.X11-unix/:/tmp/.X11-unix" \
    -v "$HOME/workspace:/workspace" \
    mycares/mmseg:latest \
    /bin/bash
```