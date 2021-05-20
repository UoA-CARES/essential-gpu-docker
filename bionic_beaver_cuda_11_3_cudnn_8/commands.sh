#!/bin/bash
# cat ~/.bashrc

# source ~/.bashrc
code-server --port 8088 --auth none > /root/cares_env/codeserver.log 2>&1 &
ttyd -p 8089 bash > /root/cares_env/ttyd.log 2>&1 &

/bin/bash
