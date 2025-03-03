#!/bin/bash


# todo gpg keys and pass

# todo ssh agent

# todo aws configure


# banner (motd) 
curl  https://raw.githubusercontent.com/korningf/vbox-aws-linux/refs/heads/main/motd > /etc/motd

# constants
REGION=us-east-1

# variables
AWS_EC2_ID=`curl -s http://169.254.169.254/latest/meta-data/instance-id`
AWS_EC2_NAME=$(aws ec2 describe-tags --region $REGION --filters "Name=resource-id,Values=$AWS_EC2_ID" "Name=key,Values=Name" --output text | cut -f5)

echo $AWS_EC2_ID >> /etc/aws_ec2_id
echo $AWS_EC2_NAME >> /etc/aws_ec2_name

systemctl enable httpd
systemctl start httpd

echo "<h1>web $AWS_EC2_ID $AWS_EC2_NAME $(hostname -f)</h1>" > /var/www/html/index.html

