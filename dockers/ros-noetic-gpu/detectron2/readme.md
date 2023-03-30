### Build
```

```

### Run
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
    -v $HOME/Downloads:/data \
    mycares/ros-noetic-detectron2:latest \
    /bin/bash
```

### Test

```
cd detectron2/demo && python3 demo.py --config-file ../configs/COCO-InstanceSegmentation/mask_rcnn_R_50_FPN_3x.yaml \
  --input /data/input.jpg \
  --output output \
  --opts MODEL.WEIGHTS detectron2://COCO-InstanceSegmentation/mask_rcnn_R_50_FPN_3x/137849600/model_final_f10217.pkl
```