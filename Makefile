# If the first argument is ...
ifneq (,$(findstring tools_,$(firstword $(MAKECMDGOALS))))
	# use the rest as arguments
	RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
	# ...and turn them into do-nothing targets
	#$(eval $(RUN_ARGS):;@:)
endif


.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[0-9a-zA-Z_-]+:.*?## / {printf "\033[36m%-42s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

# DOCKER TASKS

## NOETIC

nvidia_ros_noetic: ## [NVIDIA] Build ROS  Noetic  Container
	docker build -t turlucode/ros-noetic:nvidia -f nvidia/noetic/base/Dockerfile .
	@printf "\n\033[92mDocker Image: turlucode/ros-noetic:nvidia\033[0m\n"

nvidia_ros_noetic_cuda11-4-2: nvidia_ros_noetic ## [NVIDIA] Build ROS  Noetic  Container | (CUDA 11.4.2 - no cuDNN)
	docker build -t turlucode/ros-noetic:cuda11.4.2 -f nvidia/noetic/cuda11.4.2/Dockerfile .
	@printf "\n\033[92mDocker Image: turlucode/ros-noetic:cuda11.4.2\033[0m\n"
	
nvidia_ros_noetic_cuda11-4-2_cudnn8: nvidia_ros_noetic_cuda11-4-2 ## [NVIDIA] Build ROS  Noetic  Container | (CUDA 11.4.2 - cuDNN 8)
	docker build -t turlucode/ros-noetic:cuda11.4.2-cudnn8 -f nvidia/noetic/cuda11.4.2/cudnn8/Dockerfile .
	@printf "\n\033[92mDocker Image: turlucode/ros-noetic:cuda11.4.2-cudnn8\033[0m\n"

## BOUNCY

nvidia_ros_bouncy: ## [NVIDIA] Build ROS2 Bouncy  Container
	docker build -t turlucode/ros-bouncy:latest -f nvidia/bouncy/base/Dockerfile .
	@printf "\n\033[92mDocker Image: turlucode/ros-bouncy:latest\033[0m\n"

## Helper TASKS
nvidia_run_help: ## [NVIDIA] Prints help and hints on how to run an [NVIDIA]-based image
	 @printf "\n- Make sure the nvidia-docker-plugin (Test it with: docker run --rm --runtime=nvidia nvidia/cuda:9.0-base nvidia-smi)\n  - Command example:\ndocker run --rm -it --runtime=nvidia --privileged --net=host --ipc=host \\ \n-v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY \\ \n-v $HOME/.Xauthority:/root/.Xauthority -e XAUTHORITY=/root/.Xauthority \\ \n-v <PATH_TO_YOUR_CATKIN_WS>:/root/catkin_ws \\ \n-e ROS_IP=<HOST_IP or HOSTNAME> \\ \nturlucode/ros-indigo:nvidia\n"


# CPU

## INDIGO
cpu_ros_indigo: ## [CPU]    Build ROS  Indigo  Container
	docker build -t turlucode/ros-indigo:cpu -f cpu/indigo/base/Dockerfile .
	@printf "\n\033[92mDocker Image: turlucode/ros-indigo:cpu\033[0m\n"

## KINETIC

cpu_ros_kinetic: ## [CPU]    Build ROS  Kinetic Container
	docker build -t turlucode/ros-kinetic:cpu -f cpu/kinetic/base/Dockerfile .
	@printf "\n\033[92mDocker Image: turlucode/ros-kinetic:cpu\033[0m\n"

## MELODIC

cpu_ros_melodic: ## [CPU]    Build ROS  Melodic Container
	docker build -t turlucode/ros-melodic:cpu -f cpu/melodic/base/Dockerfile .
	@printf "\n\033[92mDocker Image: turlucode/ros-melodic:cpu\033[0m\n"

## NOETIC

cpu_ros_noetic: ## [CPU]    Build ROS  Noetic  Container
	docker build -t turlucode/ros-noetic:cpu -f cpu/noetic/base/Dockerfile .
	@printf "\n\033[92mDocker Image: turlucode/ros-noetic:cpu\033[0m\n"







docker run --rm -it --privileged --net=host --ipc=host \
--device=/dev/dri:/dev/dri \
-v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY \
-v $HOME/.Xauthority:/home/$(id -un)/.Xauthority -e XAUTHORITY=/home/$(id -un)/.Xauthority \
-e ROS_IP=127.0.0.1 \



docker run --rm -it --privileged --net=host --ipc=host \
--device=/dev/dri:/dev/dri \
-v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY \
-v $HOME/.Xauthority:/home/$(id -un)/.Xauthority -e XAUTHORITY=/home/$(id -un)/.Xauthority \
-e DOCKER_UNAME=$(id -un) \
-e DOCKER_UID=$(id -u) \
-e DOCKER_GNAME=$(id -gn) \
-e DOCKER_GID=$(id -g) \
-e ROS_IP=127.0.0.1 \
turlucode/ros-noetic:nvidia \
/bin/bash