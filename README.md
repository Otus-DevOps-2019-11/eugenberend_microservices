# eugenberend_microservices

eugenberend microservices repository

Done:

- [X] Configured ingress for reddit
- [X] Configured SSL certificate
- [X] Configured network policies
- [X] Configured PV with claims

How to run:

1. Create GKE cluster
2. Create namespace `kubectl apply -f ./kubernetes/reddit/dev-namespace.yml`
3. Deploy environment `kubectl apply -f ./kubernetes/reddit/ -n dev`
4. Choose IP of any node `kubectl get ingress -n dev` (ensure that ADDRESS isn't blank)
5. Go to <https://IP> and check that app is up and running (pls ignore SSL warning because the certificate is self-signed)
