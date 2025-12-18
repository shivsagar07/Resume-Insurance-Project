#!/bin/bash
yum update -y
yum install docker -y
service docker start
usermod -aG docker ec2-user

docker run -d -p 80:3000 YOUR_DOCKERHUB_USERNAME/health-insurance-app:latest

#YOUR_DOCKERHUB_USERNAME
