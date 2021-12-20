#!/bin/bash

# install docker
sudo apt update -y
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
apt-cache policy docker-ce
sudo apt install docker-ce -y

# Install and register runner
curl -LJO "https://gitlab-runner-downloads.s3.amazonaws.com/latest/deb/gitlab-runner_amd64.deb"
dpkg -i gitlab-runner_amd64.deb
read -p "Type group project registartion token: " REG_TOKEN
read -p "Type executor type: " EXECUTOR
read -p "Type docker imaage: " DOCKER_IMAGE

# Register gitlab-runner
sudo gitlab-runner start
sudo gitlab-runner register -n \
  --url https://gitlab.com/ \
  --registration-token $REG_TOKEN \
  --executor $EXECUTOR \
  --description "TELECOM_PROJECT" \
  --docker-image "$DOCKER_IMAGE" \
  --docker-privileged \
  --run-untagged="true" \
  --docker-volumes "/certs/client"
sudo service gitlab-runner restart

