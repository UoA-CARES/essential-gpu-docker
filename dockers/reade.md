# CARES Dockers

Please refer to [here](https://hub.docker.com/repositories/mycares)

Docker images supporting the Nvidia CUDA toolkit have been created for internal purposes.

## Kaggle Docker Python
Read the instruction [here](kaggle_gpu_python/readme.md)

## ROS Noetic GPU
Read the instruction [here](ros-noetic-gpu/readme.md)

## ROS Noetic Detectron2
Read the instruction [here](ros-noetic-gpu/detectron2/readme.md)

## Pytorch 1.13 (Cuda 11.6)

The image was built based on the [Nvidia image]((https://hub.docker.com/r/nvidia/cuda/tags?page=1&name=11.6.2-devel-ubuntu20.04)) and installed PyTorch 1.13 + CUDA 11.6 in a Conda environment. To use it, you will need to first pull it from Docker Hub.

```bash
# You should execute the following command on the workstation.
docker pull mycares/pytorch:1.13.0-cuda11.6-ubuntu20.04
```

Next, start a container by running the following command.

```bash
# You should execute the following command on the workstation.
docker run -it --runtime=nvidia -v /dev/shm:/dev/shm --mount source=datastore,target=/data mycares/pytorch:1.13.0-cuda11.6-ubuntu20.04 /bin/bash
```

After connecting to the container, activate the Conda environment for PyTorch.

```bash
# You should execute the following command within the container.
conda activate torch1.13.0
```

It is recommended to use pip to install Python packages.

---


## Detectron2 (Cuda 11.6)
The image was built based on the [Nvidia image]((https://hub.docker.com/r/nvidia/cuda/tags?page=1&name=11.6.2-devel-ubuntu20.04)) and installed PyTorch 1.13 + CUDA 11.6 + Detectron2(2023.03.21) in a Conda environment. To use it, you will need to first pull it from Docker Hub.

```bash
# You should execute the following command on the workstation.
docker pull mycares/detectron2:2023.03.21
```

Next, start a container by running the following command.

```bash
# You should execute the following command on the workstation.
docker run -it --runtime=nvidia -v /dev/shm:/dev/shm --mount source=datastore,target=/data mycares/detectron2:2023.03.21 /bin/bash
```

Once connected to the container, activate the conda environment for detectron2. 

```bash
# You should execute the following command within the container.
conda activate torch1.13.0
```

You can try a quick demo of Detectron2 by copying any image file (and naming it 'input.jpg') into the '/home/$USER/data' directory of the workstation using FileZilla Client, and then listing the file in your container. In this example, we will use the following image.

![input image](screenshot/input.jpg)

List the file in your container. 
```bash
# You should execute the following command within the container.
ls /data
```

In order to perform a quick demo, navigate to the '~/workspace/detectron2/demo' directory after verifying that the input.jpg file has been successfully transferred to your container.

```bash
# You should execute the following command within the container.
cd ~/workspace/detectron2/demo
```

Create a folder named 'output' to save the output files from the demo.

```bash
# You should execute the following command within the container.
mkdir ~/workspace/detectron2/demo/output 
```

Now, we are ready to run the demo script. 

```bash
# You should execute the following command within the container.
python demo.py --config-file ../configs/COCO-InstanceSegmentation/mask_rcnn_R_50_FPN_3x.yaml \
  --input /data/input.jpg \
  --output output \
  --opts MODEL.WEIGHTS detectron2://COCO-InstanceSegmentation/mask_rcnn_R_50_FPN_3x/137849600/model_final_f10217.pkl
```

Copy the output folder into /data in your container to see the result.

```bash
# You should execute the following command within the container.
cp -r output/ /data/
```

Once you have refreshed FileZilla Client, go to the shared directory (/home/$USER/data) on the workstation. Inside, you'll find a directory named 'output' that contains the resulting file.

![output image](screenshot/output.jpg)

Please utilize pip within this conda environment if you require additional Python packages.

---

