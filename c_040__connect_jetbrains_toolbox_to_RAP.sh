
# run this in the dx venv and get the host address: [ec2-3-8-203-151.eu-west-2.compute.amazonaws.com]
dx describe job-J1vpJkjJQp6V9VFkPFPq74qG

# run this in the toolbox
ssh -i ~/.dnanexus_config/ssh_id dnanexus@ec2-3-8-203-151.eu-west-2.compute.amazonaws.com

ssh -N -L 8888:localhost:8888 -i ~/.dnanexus_config/ssh_id dnanexus@ec2-3-8-203-151.eu-west-2.compute.amazonaws.com
