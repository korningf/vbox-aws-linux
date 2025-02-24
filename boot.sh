#!/bin/bash

# apt keyrings
mkdir -p /etc/apt/keyrings

# apt repositories 
apt update


# apt packages

# aws-cli
snap install aws-cli --classic


# banner (motd) 
curl  https://raw.githubusercontent.com/korningf/vbox-cso-linux/refs/heads/main/motd > /etc/motd

# constants
REGION=us-east-1

# variables
AWS_EC2_ID=`curl -s http://169.254.169.254/latest/meta-data/instance-id`
AWS_EC2_NAME=$(aws ec2 describe-tags --region $REGION --filters "Name=resource-id,Values=$AWS_EC2_ID" "Name=key,Values=Name" --output text | cut -f5)

echo $AWS_EC2_ID >> /etc/aws_ec2_id
echo $AWS_EC2_NAME >> /etc/aws_ec2_name

