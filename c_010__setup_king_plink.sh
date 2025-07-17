#!/bin/bash


# snapshot name: file-J1f5yf8JQp6qB2KXYXg08fxY: user_data__Mahdi/snapshot_A1__snipar_conda
#dx run --instance-type mem1_ssd1_v2_x2 app-cloud_workstation -isnapshot=file-J1f5yf8JQp6qB2KXYXg08fxY --ssh -y
# the above command deosn't work at least now it doesn't load the snapshot
# but when I create the machine using the RAP GUI it loads the snapshot correctly

pyenv activate dx
dx ssh job-

dx-set-timeout 4h


# check wehre the snipar is installed is it in the conda env?
# snipar is installedn in the py39 conda environment, so we need to activate it first before use

# installing king
#wget https://www.kingrelatedness.com/linuxKING.tar.gz
# above cmd doesn't work, doesn't have access to internet,
# so I will download it from my local machine and upload it to the RAP

# download the manulaly uploaded file: Linux-king.tar onto the instance
dx download file-J1qb5x8JQp6jKG39BB8k5Kbv

# extract the tar file
tar -xvf Linux-king.tar
# make the king executable
chmod +x king
# check installation
./king
# add current dir to the PATH
echo 'export PATH=$PATH:'"$(pwd)" >> ~/.bashrc
# check king
king
# remove the tar file
rm Linux-king.tar



# installing plink1.9
wget https://s3.amazonaws.com/plink1-assets/plink_linux_x86_64_20250615.zip
unzip plink_linux_x86_64_20250615.zip
chmod +x ~/plink
# $HOME is already in the PATH, so we can use plink directly
# check plink installation
plink --version
# remove the zip file
rm plink_linux_x86_64_20250615.zip


# replace snapshot of the machine for later use
dx-create-snapshot --name user_data__Mahdi/A1_snapshot__conda_snipar_king_plink
