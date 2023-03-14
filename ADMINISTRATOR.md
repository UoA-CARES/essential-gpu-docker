# Install Ubuntu 22.04
- install ubuntu 22.04 destop  (https://releases.ubuntu.com/22.04/)
- Click 'Show Application' > 'Additional Drivers' and choose 'Using NVIDIA driver metapackage from nvidia-driver-510(proprietary)', then reboot the system. 


# Add a user
You can add a user(myuser1/pass1) as follows. You can change id(myuser1) and password(pass1) as you want. 
```
sudo adduser myuser1 --gecos "myuser1,RoomNumber,WorkPhone,HomePhone" --disabled-password
echo "myuser1:pass1" | sudo chpasswd
```

# Install openssh-server
```
sudo apt install openssh-server
```
Now, you can connect the system using ssh. 
```
ssh username@ipaddress
```

# Install Nvidia Docker
- Install Docker CE (https://docs.docker.com/engine/install/ubuntu/)
- Install Nvidia Docker (https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker)
- Install Docker Compose
```
sudo apt install docker-compose
```
- Add the user into the docker group
```
sudo usermod -aG docker myuser1
```

Now, you can try the following command. 
```
docker run --rm --runtime=nvidia --gpus all nvidia/cuda:11.6.2-base-ubuntu20.04 nvidia-smi
```
You shuold see the output of nvidia-smi. 

# Set docker default runtime as nvidia
Use docker run with nvidia as the default runtime
You can set nvidia as the default runtime, for example, by adding the following line to the /etc/docker/daemon.json configuration file as the first entry.
```
"default-runtime": "nvidia",
```
The following is an example of how the added line appears in the JSON file. Do not remove any pre-existing content when making this change.
```
{
 "default-runtime": "nvidia",
  "runtimes": {
     "nvidia": {
         "path": "/usr/bin/nvidia-container-runtime",
         "runtimeArgs": []
     }
 },
}
```
Reboot the system and try the following command. 
```
docker run --rm --gpus all nvidia/cuda:11.6.2-base-ubuntu20.04 nvidia-smi
```
You shuold see the output of nvidia-smi. 

# Install Portrainer 
We use Portrainer to manage docker containers. Run the Portainer as a docker and visit https://localhost:9443 to set the admin account. 
```
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
```

We can easily monitor and manage all the containers, images, networks and volumes on the web. 
Home:
![home](screenshot/portainer1.png)
Dashboard:
![dashboard](screenshot/portainer2.png)
Containers:
![containers](screenshot/portainer3.png)
Container details:
![container details](screenshot/portainer4.png)
Container logs:
![container logs](screenshot/portainer5.png)
Container console:
![container console](screenshot/portainer6.png)