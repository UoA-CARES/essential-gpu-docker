# ubuntu-gpu-vnc

ubuntu 20.04
code-server
novnc
web terminal

# install nvidia-docker
```
sudo apt install curl
bash <(curl -Ls https://gist.githubusercontent.com/jlim262/779f5f63353016c3c7d744f128fc7a77/raw/eecf9c0648fd5e301064bf759c26c3231ef59e3c/nvidia_docker_install.sh)
```

# add user
```
sudo adduser myuser1 --gecos "myuser1,RoomNumber,WorkPhone,HomePhone" --disabled-password
echo "myuser1:pass1" | sudo chpasswd
sudo mkdir -p /home/myuser1/workspace
sudo chown -R myuser1:myuser1 /home/myuser1/workspace
sudo chmod 777 /home/myuser1/workspace
```

# Run Docker
```
sudo docker run -d --privileged --gpus all --name gpud74myuser1 -e USER=myuser1 -e PASSWORD=pass1 -e HTTP_PASSWORD=pass1 -p 8443:8443 -p 6080:80 -p 5900:5900 -p 8089:8089 -v /dev/shm:/dev/shm -v /home/myuser1/workspace:/workspace --restart unless-stopped mycares/ubuntu-gpu-vnc:latest
```

# Launch web terminal
web_vnc - ipaddress:6080
web_vscode - ipaddress:8443
web_terminal - ipaddress:8089

