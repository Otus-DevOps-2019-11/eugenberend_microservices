# eugenberend_microservices

eugenberend microservices repository

Done:

- [X] Configured notifications to Slack channel <https://devops-team-otus.slack.com/archives/CRH4T9QG3>
- [X] Automated gitlab runner provision with Ansible
- [X] Integrated container build and deployment into the pipeline

How to run:

- Build an image with packer: ```cd gitlab-ci/provide-image && packer build -var-file=variables.json.example docker-host.json```
- Deploy an instance: ```cd ../deploy-instances && terraform apply -auto-approve```
- On the new instance, copy this repo, cd to gitlab-ci and deploy Gitlab CI: ```docker-compose up -d```
- Configure root password and environment variables for Docker Hub login
- Create runner(s): ```cd deploy-multiple-gitlab-runners && ansible-playbook deploy-runners.yml``` (you can loop this command to create multiple runners)
- Push this repo to Gitlab
- Check that job is completed successfully
