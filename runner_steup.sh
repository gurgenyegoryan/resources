#!/bin/bash
curl -LJO "https://gitlab-runner-downloads.s3.amazonaws.com/latest/deb/gitlab-runner_amd64.deb"
dpkg -i gitlab-runner_amd64.deb
read -p "Type group project registartion token: " REG_TOKEN
read -p "Type executor type: " EXECUTOR
sudo gitlab-runner start
sudo gitlab-runner register -n --url https://gitlab.com/ --registration-token $REG_TOKEN --executor $EXECUTOR --description "Telecom Project Runner" --docker-image "docker:stable" --tag-list deployment --docker-privileged
sudo systemctl restart gitlab-runner.service

