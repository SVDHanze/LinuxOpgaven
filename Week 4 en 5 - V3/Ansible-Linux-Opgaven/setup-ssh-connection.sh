#!/bin/bash

# Installs SSH and UFW, to allow a connection to the server
sudo apt-get install openssh-server -y
sudo apt-get install ufw -y
sudo ufw allow ssh
sudo ufw reload
sudo ufw enable
sudo systemctl enable ssh-server
sudo systemctl enable ufw
