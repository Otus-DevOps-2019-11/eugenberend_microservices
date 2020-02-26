docker build -t evgeniyberendyaev/post:1.0 ./post-py -f ./post-py/Dockerfile.1
docker build -t evgeniyberendyaev/comment:1.0 ./comment -f ./comment/Dockerfile.1
docker build -t evgeniyberendyaev/ui:1.0 ./ui -f ./ui/Dockerfile.1
