#!/bin/sh
docker network create reddit

docker run -d --network=reddit \
--network-alias=post_database --network-alias=comment_database mongo:latest

docker run \
-e POST_DATABASE_HOST='post_database' \
-d --network=reddit \
--network-alias=post_service evgeniyberendyaev/post:1.0

docker run \
-e COMMENT_DATABASE_HOST='comment_database' \
-d --network=reddit \
--network-alias=comment_service evgeniyberendyaev/comment:1.0

docker run \
-e POST_SERVICE_HOST='post_service' \
-e COMMENT_SERVICE_HOST='comment_service' \
-d --network=reddit \
-p 9292:9292 evgeniyberendyaev/ui:1.0
