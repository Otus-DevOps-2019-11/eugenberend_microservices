 docker-machine create --driver google \
 --google-machine-image $(gcloud compute images list --uri | grep ubuntu-1604) \
 --google-machine-type n1-standard-1 \
 --google-zone europe-north1-a \
 docker-host

 gcloud compute firewall-rules create reddit-app \
 --allow tcp:9292 \
 --target-tags=docker-machine \
 --description="Allow PUMA connections" \
 --direction=INGRESS
