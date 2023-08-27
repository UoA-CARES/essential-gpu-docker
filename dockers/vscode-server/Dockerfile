# Base image
# FROM nvidia/cuda:11.7.1-cudnn8-devel-ubuntu20.04
# FROM mycares/kaggle-gpu-python:latest
FROM gcr.io/kaggle-gpu-images/python:v132

# Set working directory
WORKDIR /

ENV DEBIAN_FRONTEND=noninteractive \
    VSCODE_SERVE_MODE=remote


RUN apt-get update -y && \
    apt-get install -y --no-install-recommends openssh-server

# Install System Packages
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends \
    git             \
    nginx           \
    tzdata          \
    expect          \    
    build-essential \
    # python3.10-dev python3.10-venv \
    gnome-keyring wget curl ca-certificates \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*



    # apt-get remove -y libssl-dev openssh-client openssh-server && \
    # apt-get install -y --no-install-recommends libssl-dev openssh-client openssh-server
# RUN mamba install openssh -y


# Set up Python and pip
# RUN ln -s /usr/bin/python3.10 /usr/bin/python && \
#     rm /usr/bin/python3 && \
#     ln -s /usr/bin/python3.10 /usr/bin/python3 && \
#     curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
#     python get-pip.py

RUN pip install --upgrade pip && pip install jupyterlab

# RUN pip install nvidia-pyindex
# RUN pip install nvidia-tensorrt==7.2.3.4
# RUN echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/conda/lib/python3.7/site-packages/tensorrt/' >> /root/.bashrc
# RUN echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/conda/lib/python3.7/site-packages/tensorrt/' >> /opt/conda/etc/conda/activate.d/env_vars.sh

# Install vscode-server
RUN wget -q -O- https://aka.ms/install-vscode-server/setup.sh | sh && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# copy scripts
COPY src/* /usr/local/bin/

# expose port
EXPOSE 8000

# NGINX Proxy
RUN wget -O init-deb.sh https://www.linode.com/docs/assets/660-init-deb.sh && \
    mv init-deb.sh /etc/init.d/nginx && \
    chmod +x /etc/init.d/nginx && \
    /usr/sbin/update-rc.d -f nginx defaults

COPY --from=proxy nginx.conf /etc/nginx/nginx.conf
COPY --from=proxy readme.html /usr/share/nginx/html/readme.html

# Copy the README.md
COPY README.md /usr/share/nginx/html/README.md

# Start Scripts
COPY post_start.sh /post_start.sh
COPY --from=scripts start.sh /
RUN chmod +x /start.sh

CMD [ "/start.sh" ]
