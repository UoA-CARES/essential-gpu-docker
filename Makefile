help:
	@awk 'BEGIN {FS = ":.*?## "} /^[0-9a-zA-Z_-]+:.*?## / {printf "\033[36m%-42s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help


## KAGGLE PYTHON
kaggle-gpu-python: ## Build Kaggle Docker Python
	docker build -t mycares/kaggle-gpu-python:latest -f dockers/kaggle_gpu_python/Dockerfile .
	@printf "\n\033[92mDocker Image: mycares/kaggle-gpu-python:latest\033[0m\n"

## ROS NOETIC
ros_noetic_gpu: ## Build ROS Noetic
	docker build -t mycares/ros-noetic-gpu:latest -f dockers/ros-noetic-gpu/Dockerfile .
	@printf "\n\033[92mDocker Image: mycares/ros-noetic-gpu:latest\033[0m\n"

ros_noetic_detectron2: ros_noetic_gpu ## Build Detectron2 on ROS Noetic
	docker build -t mycares/ros-noetic-detectron2:latest -f dockers/ros-noetic-gpu/detectron2/Dockerfile .
	@printf "\n\033[92mDocker Image: mycares/ros-noetic-detectron2:latest\033[0m\n"

## MMSegmentation
mmseg: ## Build mmsegmentation
	docker build -t mycares/mmseg:latest -f dockers/mmsegmentation/Dockerfile .
	@printf "\n\033[92mDocker Image: mycares/mmseg:latest\033[0m\n"

## Image-Segmentation
imgseg: ## Build imgseg
	docker build -t mycares/imgeg:latest -f dockers/imgseg/Dockerfile .
	@printf "\n\033[92mDocker Image: mycares/imgseg:latest\033[0m\n"
	