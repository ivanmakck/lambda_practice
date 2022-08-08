#!/bin/bash

# install specific python version
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt-get update
sudo apt install python3.8 -y
sudo apt install python3.8-distutils -y
sudo apt install unzip -y

# install aws cli
AWS=awscliv2.zip
if [ ! -f "$AWS" ]
then
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
fi

# create virtual env for python 3.8
sudo apt install python3-virtualenv -y
virtualenv -p="/usr/bin/python3.8" sandbox
source sandbox/bin/activate

# install dependencies
pip install -r requirements.txt

# deactivate virtual environment
deactivate

# make run.sh executable
chmod a+x run.sh

# create log folder
mkdir -p log