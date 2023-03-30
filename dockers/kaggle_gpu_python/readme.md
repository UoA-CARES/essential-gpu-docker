### Build 
```
cd PATH_TO_ESSENTIAL_GPU_DOCKER/docker
make kaggle-gpu-python
```

### Run
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
    -v "$HOME/projects:/workspace" \
    mycares/kaggle-gpu-python:latest \
    /bin/bash
```

### Test
```
python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"
```