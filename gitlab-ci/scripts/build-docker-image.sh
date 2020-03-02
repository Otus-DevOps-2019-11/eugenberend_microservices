#!/bin/sh
docker info
docker build -t reddit-$CI_COMMIT_REF_NAME:$CI_PIPELINE_IID .
docker tag reddit-$CI_COMMIT_REF_NAME:$CI_PIPELINE_IID evgeniyberendyaev/gitlab-reddit:$CI_PIPELINE_IID
docker login -u $DOCKER_LOGIN -p $DOCKER_PASS
docker push evgeniyberendyaev/gitlab-reddit:$CI_PIPELINE_IID
