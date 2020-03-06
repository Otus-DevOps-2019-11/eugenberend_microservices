USER_NAME = evgeniyberendyaev

docker-build-all: docker-build-alertmanager docker-build-ui docker-build-comment docker-build-post docker-build-prometheus docker-build-blackbox_exporter docker-build-mongodb_exporter docker-push-images

docker-build-alertmanager:
	cd ./monitoring/alertmanager && docker build -t ${USER_NAME}/alertmanager .

docker-build-ui:
	cd ./src/ui && bash ./docker_build.sh

docker-build-comment:
	cd ./src/comment && bash ./docker_build.sh

docker-build-post:
	cd ./src/post-py && bash ./docker_build.sh

docker-build-blackbox_exporter:
	cd ./monitoring/blackbox_exporter && docker build -t ${USER_NAME}/blackbox_exporter .

docker-build-mongodb_exporter:
	cd ./monitoring/mongodb_exporter && docker build -t ${USER_NAME}/mongodb_exporter .

docker-build-prometheus:
	cd ./monitoring/prometheus && docker build -t ${USER_NAME}/prometheus .

docker-push-images: docker-alertmanager-push docker-ui-push docker-comment-push docker-post-push docker-blackbox_exporter-push docker-prometheus-push docker-mongodb_exporter-push

docker-alertmanager-push:
	docker push ${USER_NAME}/alertmanager

docker-ui-push:
	docker push ${USER_NAME}/ui

docker-comment-push:
	docker push ${USER_NAME}/comment

docker-post-push:
	docker push ${USER_NAME}/post

docker-blackbox_exporter-push:
	docker push ${USER_NAME}/blackbox_exporter

docker-mongodb_exporter-push:
	docker push ${USER_NAME}/mongodb_exporter

docker-prometheus-push:
	docker push ${USER_NAME}/ui
