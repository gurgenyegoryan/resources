#!/bin/bash

REGION=eu-west-1

aws ecr describe-repositories --repository-names $CI_PROJECT_NAME >> /dev/null || aws ecr create-repository --repository-name $REPO_NAME --region $REGION

###GET repositoryURI for builing out images
DOCKER_REGISTRY=`aws ecr describe-repositories --repository-names test | grep "repositoryUri" | awk -F ": " '{print $2}'`

### Login docker in aws ecr for per
aws ecr get-login-password | docker login --username AWS --password-stdin $DOCKER_REGISTRY