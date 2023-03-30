### Prerequisites
[Install Nvidia Docker](https://github.com/UoA-CARES/essential-gpu-docker/blob/main/ADMINISTRATOR.md#install-nvidia-docker)

### Build 

To build ROS Noetic docker image, 
```
sudo apt update && sudo apt install -y build-essential
cd PATH_TO_ESSENTIAL_GPU_DOCKER/dockers
make ros_noetic_gpu
```


### Run
To access all the code in your local workspace, use the '-v $HOME/workspace:/workspace' option to mount your workspace to the container. The container's default user is 'root', so avoid modifying any files in the container and use it only for training purposes. If you do add or modify files in the container, you won't be able to view them on your local machine due to permission issues. (To view those files, you'll need to adjust their permissions.)

To run ROS Noetic docker image, 
```
docker run --rm -it \
    --network host \
    --gpus all \
    --privileged \
    --device=/dev/dri:/dev/dri \
    -e NVIDIA_VISIBLE_DEVICES=all \
    -e NVIDIA_DRIVER_COMPABILITIES=all \
    -v /dev/shm:/dev/shm \
    -e QT_X11_NO_MITSHM=1 \
    -e DISPLAY=$DISPLAY \
    -v "/tmp/.X11-unix/:/tmp/.X11-unix" \
    -v "$HOME/workspace:/workspace" \
    -v $HOME/Downloads:/data \
    mycares/ros-noetic-gpu:latest \
    /bin/bash
```

### Test

```
roscore 
```
```
nvidia-smi
```
