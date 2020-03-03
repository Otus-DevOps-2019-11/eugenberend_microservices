export GOOGLE_PROJECT=docker-267808
docker-machine create --driver google \
    --google-machine-image https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/family/ubuntu-1604-lts \
    --google-machine-type n1-standard-1 \
    --google-zone europe-north1-b \
    docker-host
eval $(docker-machine env docker-host)
