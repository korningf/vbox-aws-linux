#!/bin/bash

# apt keyrings
mkdir -p /etc/env
mkdir -p /etc/apt/keyrings

# apt repositories 
apt update


# apt packages

# aws-cli
apt-get -y aws-cli --classic

# apache httpd
apt-get -y httpd --classic


# banner (motd) 
curl  https://raw.githubusercontent.com/korningf/vbox-aws-linux/refs/heads/main/motd > /etc/motd

# constants
REGION=us-east-1

# variables
AWS_EC2_ID=`curl -s http://169.254.169.254/latest/meta-data/instance-id`
AWS_EC2_IP=`curl -s http://169.254.169.254/latest/meta-data/local-ipv4`
AWS_EC2_HOST=`curl -s http://169.254.169.254/latest/meta-data/local-hostname`
AWS_PUB_IP=`curl -s http://169.254.169.254/latest/meta-data/public-ipv4`
AWS_PUB_HOST=`curl -s http://169.254.169.254/latest/meta-data/public-hostname`

AWS_TAG_NAME=$(aws ec2 describe-tags --region $REGION --filters "Name=resource-id,Values=$AWS_EC2_ID" "Name=key,Values=Name" --output text | cut -f5)

echo $AWS_EC2_ID >> /etc/env/aws_ec2_id
echo $AWS_EC2_IP >> /etc/env/aws_ec2_ip
echo $AWS_EC2_HOST >> /etc/env/aws_ec2_host
echo $AWS_PUB_IP >> /etc/env/aws_pub_ip
echo $AWS_PUB_HOST >> /etc/env/aws_pub_host

echo $AWS_TAG_NAME >> /etc/env/aws_ec2_name

