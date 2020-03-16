# eugenberend_microservices

eugenberend microservices repository

Done:

- [X] Deployed Kubernetes cluster in GCP
- [X] Written Ansible (bashsible) playbooks to not to use `tmux`
- [X] Deployed microservices as PoC

How to run:

1. `cd kubernetes/the_hard_way`
2. Create resources: `../ansible/scripts/compute-resources.sh`
3. Generate SSH key: `gcloud compute ssh controller-0`
4. Provide certs: `../ansible/scripts/certificate-authority.sh`
5. Distribute certs: `../ansible/scripts/distribute-certs.sh`
6. Provide configs: `../ansible/scripts/kubernetes-configuration-files.sh`
7. Distribute certs: `../ansible/scripts/distribute-configs.sh`
8. Generate data encryption config and key: `data-encryption-keys`
9. Bootstrap the etcd cluster: `cd ../ansible && ansible-playbook etcd.yml`
10. Bootstrap controllers: `ansible-playbook controllers.yml`
11. Enable RBAC: `ansible-playbook rbac.yml`
12. Enable NLB: `./scripts/create-nlb.sh`
13. Bootstrap workers: `ansible-playbook workers.yml`
14. Configure kubectl for Remote Access: `cd ../the_hard_way && ../ansible/scripts/configure-kubectl-for-remote-access.sh`
15. Create Pod Routes: `../ansible/scripts/create-network-routes.sh`
16. Deploy CoreDNS: `../ansible/scripts/deploy-coredns.sh`
17. Run smoke test: `../ansible/scripts/smoke-test.sh`
18. Run services deployment: `../reddit/deploy-services.sh`
19. Delete all: `../ansible/scripts/delete-all.sh`
