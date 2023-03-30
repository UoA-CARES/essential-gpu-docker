### Prerequisites
[Install Nvidia Docker](https://github.com/UoA-CARES/essential-gpu-docker/blob/main/ADMINISTRATOR.md#install-nvidia-docker)

### Build 
```
sudo apt update && sudo apt install -y build-essential
cd PATH_TO_ESSENTIAL_GPU_DOCKER/dockers
make kaggle-gpu-python
```

### Run
To access all the code in your local workspace, use the '-v $HOME/workspace:/workspace' option to mount your workspace to the container(replace '$HOME/workspace' with your workspace path). The container's default user is 'root', so avoid modifying any files in the container and use it only for training purposes. 

```
docker run -it \
    --privileged \
    --gpus all \
    --runtime=nvidia \
    --device=/dev/dri:/dev/dri \
    -e NVIDIA_VISIBLE_DEVICES=all \
    -e NVIDIA_DRIVER_COMPABILITIES=all \
    -e QT_X11_NO_MITSHM=1 \
    -e DISPLAY=$DISPLAY \
    -v "/tmp/.X11-unix/:/tmp/.X11-unix" \
    -v "$HOME/workspace:/workspace" \
    mycares/kaggle-gpu-python:latest \
    /bin/bash
```

If you do add or modify files in the container, you won't be able to view them on your local machine due to permission issues. To view those files, you'll need to adjust their permissions.
```bash
# You should execute the following command on the workstation (not within the container).
sudo chown -R $(id -un):$(id -gn) PATH_TO_YOUR_DIRECTORY
```

### Test
```
python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"
```