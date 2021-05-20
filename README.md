# essential-gpu-docker

Docker scripts for cuda-enabled ubuntu with essential libraries for DNN.

# Install Docker

Follow the instructions from the official docker site (https://docs.docker.com/engine/install/ubuntu/)

# Install Nvidia-Docker

Follow the instruction from the official nvidia-docker site(
https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker)

# Build Docker Image

```
git clone https://github.com/UoA-CARES/essential-gpu-docker.git
cd essential-gpu-docker/bionic_beaver_cuda_11_3_cudnn_8
docker build . -t cares-bionic
```

# Run Docker

```
nvidia-docker run --network host -it cares-bionic
```

# Launch web terminal

After running the docker, browse http://ipaddress:8089 to launch web terminal.

# Launch web Visual Studio Code

Visual Studio Code is a freeware source-code editor made by Microsoft for Windows, Linux and macOS. Features include support for debugging, syntax highlighting, intelligent code completion, snippets, code refactoring, and embedded Git.

After running the docker, browse http://ipaddress:8088 to launch web Visual Studio Code.

# Portainer

Portainer is an open-source management UI for Docker, including Docker Swarm environment. Portainer makes it easier for you to manage your Docker containers, it allows you to manage containers, images, networks, and volumes from the web-based Portainer dashboard.

```
docker volume create portainer_data
```

```
docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
```
