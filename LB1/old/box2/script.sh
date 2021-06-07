#!/bin/bash

# Aaron Gensetter M300

DATA_USER="ncdata"
DATA_PW="Password123"

apt update -y
apt upgrade -y

#apt install samba -y
#useradd $DATA_USER -s /bin/bash -m # Create new user with bash shell and Home
#mkdir "/home/${DATA_USER}/data"
#echo "${DATA_USER}:${DATA_PW}" | chpasswd # Change PW of created user
#(echo "${DATA_PW}"; sleep 1; echo "${DATA_PW}") | smbpasswd -s -a "${DATA_USER}"
#tee -a /etc/samba/smb.conf << EOF
#[test]
#comment = test share
#path = /home/${DATA_USER}/data
#browsable = yes
#Valid users = ncdata
#read only = no
#EOF
#service smbd restart