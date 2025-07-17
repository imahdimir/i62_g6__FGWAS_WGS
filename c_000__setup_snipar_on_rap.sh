#!/bin/bash

#pyenv activate dx
#dx login

dx run --instance-type mem1_ssd1_v2_x8 app-cloud_workstation

dx ssh job-J1f2zFQJQp6vXkV49Bkg26bQ

unset DX_WORKSPACE_ID
dx cd $DX_PROJECT_CONTEXT_ID:


dx-set-timeout 4h


# download miniconda installer
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
# run the installer
bash ~/miniconda.sh -b -p $HOME/miniconda
# initialize conda
~/miniconda/bin/conda init bash
# reload the shell
exec bash


# Install Python 3.9 environment (snipar requires Python 3.9)
conda create -n py39 python=3.9 -y
# Activate the environment
conda activate py39


# install snipar from source
git clone https://github.com/AlexTISYoung/snipar
cd snipar

pip install --upgrade pip
pip install .


# save snapshot of the machine for later use
dx-create-snapshot --name user_data/snapshot_A_1__snipar_conda
