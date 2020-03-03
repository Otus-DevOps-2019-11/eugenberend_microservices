#!/bin/sh
docker network create back_net --subnet=10.0.2.0/24
docker network create front_net --subnet=10.0.1.0/24

docker run -d --network=front_net -p 9292:9292 --name ui evgeniyberendyaev/ui:1.0
docker run -d --network=back_net --name comment evgeniyberendyaev/comment:1.0
docker run -d --network=back_net --name post evgeniyberendyaev/post:1.0
docker run -d --network=back_net --name mongo_db \
    --network-alias=post_db --network-alias=comment_db \
    -v reddit_db:/data/db mongo:latest

docker network connect front_net post
docker network connect front_net comment
