#!/bin/bash

PI_USER=pi
PI_HOME=/home/$PI_USER

# Create pi user (if not already present)
if ! id -u $PI_USER >/dev/null 2>&1; then
    /usr/sbin/groupadd $PI_USER
    /usr/sbin/useradd $PI_USER -g $PI_USER -G sudo -d $PI_HOME --create-home
    echo "${PI_USER}:${PI_USER}" | chpasswd
fi

# Set up sudo
echo "${PI_USER}        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

# Install pi keys
mkdir -p $PI_HOME/.ssh
chmod 700 $PI_HOME/.ssh
cd $PI_HOME/.ssh
#wget --no-check-certificate "${PI_KEY_URL}" -O authorized_keys
cp /tmp/authorized_key $PI_HOME/.ssh/authorized_keys
cp /tmp/id_rsa.pub $PI_HOME/.ssh/id_rsa.pub
cp /tmp/id_rsa $PI_HOME/.ssh/id_rsa
rm -rfv /tmp/id_rsa* /tmp/authorized_key
chmod 600 $PI_HOME/.ssh/authorized_keys
chmod 600 $PI_HOME/.ssh/id_rsa
chown -R $PI_USER:$PI_USER $PI_HOME/.ssh
#passwd pi raspberry

