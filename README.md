For the administrator instruction, please visit [here](ADMINISTRATOR.md).

# Run docker
Search dockers you want [here](https://hub.docker.com/).

For the quick review, 
```
docker run hello-world
```
Check [nvidia/cuda](https://hub.docker.com/r/nvidia/cuda) dockerhub for more tags. 
```
docker run nvidia/cuda:11.6.2-base-ubuntu20.04 nvidia-smi
```

To list the running containers, simply execute the docker ps command, 
```
docker ps
```
To include all the containers present on your Docker host, append the -a option, 
```
docker ps -a
```
To stop one or more running Docker containers, you can use the docker stop command
```
docker stop container-name
```
To start containers, 
```
docker start container-name
```
And you can kill containers. 
```
docker kill container-name
```
To run an interactive shell in a container
```
docker exec -it container-name sh
```

Visit [the official docs](https://docs.docker.com/engine/reference/run/) to see all the docker commands and their options. 


# Docker volume for the persistant data 
[Youtube tutorial](https://www.youtube.com/watch?v=OrQLrqQm4M0)

In the following example, we create a volume mapped to /home/myuser1/data path. This volume will be mounted in a container. 
```
docker volume create --name datastore --opt type=none --opt device=/home/myuser1/data --opt o=bind
```
To mount the volume to your container,
```
docker run --rm -it --mount source=datastore,target=/data gcr.io/kaggle-gpu-images/python /bin/bash
```
The volume(datastore) is mounded on /data in the container

# (Optional) FileBrowser 
Install [FileBrowser](https://filebrowser.org/installation) if you want to use web-based file browser instead termimal. 

Create folder and files to use FileBrowser as a docker container. 
```
mkdir filebrowser
cd filebrowser/
touch docker-compose.yml
touch filebrowser.db
```

Check your uid/gid. We'll use uid/gid for docker-compose.yml.
```
id
```

We need to edit docker-compose.yml. 
```
nano docker-compose.yml 
```

Use your uid:gid instead '1001:1001'. And use your userid instead 'myuser1'. 
```
version: '3'
services:
  file-browser:
    image: filebrowser/filebrowser
    container_name: file-browser
    user: 1001:1001
    ports:
      - 8082:80
    volumes:
      - /home/myuser1/:/srv
      - /home/myuser1/filebrowser/filebrowser.db:/database.db
    restart: unless-stopped
    security_opt:
      - no-new-privileges:true
```
And run the docker-compose. 
```
docker-compose up -d
```
Visit http://localhost:8082 to access FileBrowser. 




