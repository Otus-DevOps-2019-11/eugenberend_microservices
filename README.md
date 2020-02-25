# eugenberend_microservices

eugenberend microservices repository

Done:

- [X] Added explanation for ```docker inspect image``` vs ```docker inspect container``` output difference
- [X] Deployed a docker machine in GCP
- [X] Uploaded my new reddit image to Docker Hub
- [X] Written code for app deployment:
  - [X] Rename ```variables.json.example``` to ```variables.json```. Populate it with your own project ID. Provide packer image with ```provide-image/provide-image.sh``` (uses Ansible playbook for Docker deployment)
  - [X] Rename ```terraform.tfvars.example``` to ```terraform.tfvars```. Populate it with your own project ID. Provide packer image with ```deploy-instances/deploy-instances.sh```
  - [X] Rename ```inventory.gcp.yml.example``` to ```inventory.gcp.yml```. Populate it with your own project ID and credentials file. Provide packer image with ```deploy-application/deploy-application.sh```
