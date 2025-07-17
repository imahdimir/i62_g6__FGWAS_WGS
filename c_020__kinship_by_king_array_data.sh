#!/bin/bash


#dx run --instance-type mem1_ssd1_v2_x36 -isnapshot=user_data__Mahdi/snipar_and_conda_installed_snapshot app-cloud_workstation --ssh -y
#dx ssh job-J1qQP6jJQp6fXvgQBv8G21VB

dx-set-timeout 4h


# download all the array data from this path
mkdir array_data
# only download files not the subdirectories and save it to /arra
dx download "project-J1VzYJQJQp6z67g2f0Vvb2kK:/Bulk/Genotype Results/Genotype calls/*" --recursive --output array_data/
# I could not find a way to NOT download the subdirectories, so I will delete them later
# delete the subdirectories
cd array_data
rm -rf */*

# create the merge list file for plink, to merge the bed files
ls *.bed | sed 's/\.bed$//' > merge_list.txt

# merge all the array data files into one big bed file using plink
plink --merge-list merge_list.txt --make-bed --out merged_data

# now we have a merged bed file, we can use it for kinship
# calculate the kinship matrix using KING
king -b merged_data.bed --related --degree 1 --prefix array_data__kinship_degree1
