# eugenberend_microservices

eugenberend microservices repository

Done:

- [X] Deployed GKE cluster
- [X] Deployed reddit microservices

How to run:

1. Create GKE cluster
2. Create namespace `kubectl apply -f ./kubernetes/reddit/dev-namespace.yml`
3. Deploy environment `kubectl apply -f ./kubernetes/reddit/ -n dev`
4. Choose IP of any node `kubectl get nodes -o wide`
5. Show node port for published app `kubectl describe service ui -n dev | grep NodePort`
6. Go to IP:port and check that app is up and running
