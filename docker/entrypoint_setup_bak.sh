#! /bin/bash

add_user () {
    UNAME=$1
    UID=$2
    GNAME=$3
    GID=$4

    ## Create user
    useradd -m $UNAME

    cp /root/.profile /home/$UNAME/
    cp /root/.bashrc /home/$UNAME/

    if [ -d "/root/.ssh" ]; then
        cp -rf /root/.ssh /home/$UNAME/
        chown -R $UID:$GID /home/$UNAME/.ssh
    fi
    
    chown $UID:$GID /home/$UNAME
    chown -R $UID:$GID /home/$UNAME/.config
    chown $UID:$GID /home/$UNAME/.profile
    chown $UID:$GID /home/$UNAME/.bashrc

    ## This a trick to keep the evnironmental variables of root which is important!
    echo "if ! [ \"$UNAME\" = \"$(id -un)\" ]; then" >> /root/.bashrc
    echo "    cd /home/$UNAME" >> /root/.bashrc
    echo "    su $UNAME" >> /root/.bashrc
    echo "fi" >> /root/.bashrc

    PASSWDCONTENTS=$(grep -v "^${UNAME}:" /etc/passwd)
    GROUPCONTENTS=$(grep -v -e "^${GNAME}:" -e "^docker:" /etc/group)

    (echo "${PASSWDCONTENTS}" && echo "${UNAME}:x:$UID:$GID::/home/$UNAME:/bin/bash") > /etc/passwd
    (echo "${GROUPCONTENTS}" && echo "${GNAME}:x:${GID}:") > /etc/group
    (if test -f /etc/sudoers ; then echo "${UNAME}  ALL=(ALL)   NOPASSWD: ALL" >> /etc/sudoers ; fi)
}


# USE_NON_ROOT=true;
if [ -z ${DOCKER_UNAME+x} ] || [ -z ${DOCKER_UID+x} ] || [ -z ${DOCKER_GNAME+x} ] || [ -z ${DOCKER_GID+x} ]
then 
    echo -e "\033[0;32mSetting up environment for user=root\033[0m"
    DOCKER_UNAME="root"
else
    echo -e "\033[0;32mAdd configuration for $DOCKER_UNAME\033[0m"
    add_user $DOCKER_UNAME $DOCKER_UID $DOCKER_GNAME $DOCKER_GID
fi

# if [ -z ${DOCKER_UID+x} ]; then 
#     USE_NON_ROOT=false;
# else
#     if ! [ -z "${DOCKER_UID##[0-9]*}" ]; then 
#         echo -e "\033[1;33mWarning: User-ID should be a number. Falling back to defaults.\033[0m"
#         USE_NON_ROOT=false;
#     fi
# fi

# if [ -z ${DOCKER_GNAME+x} ]; then 
#     USE_NON_ROOT=false;
# fi

# if [ -z ${DOCKER_GID+x} ]; then 
#     USE_NON_ROOT=false;
# else
#     if ! [ -z "${DOCKER_GID##[0-9]*}" ]; then 
#         echo -e "\033[1;33mWarning: Group-ID should be a number. Falling back to defaults.\033[0m"
#         USE_NON_ROOT=false;
#     fi
# fi

# if [ $USE_NON_ROOT == true ]; then
#     echo -e "\033[0;32mAdd configuration for $DOCKER_UNAME\033[0m"
#     add_user $DOCKER_UNAME $DOCKER_UID $DOCKER_GNAME $DOCKER_GID
# else
#     echo -e "\033[0;32mSetting up environment for user=root\033[0m"
#     DOCKER_UNAME="root"
# fi

"$@"
