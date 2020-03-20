# eugenberend_microservices

eugenberend microservices repository

1. Install nginx-ingress `helm3 install nginx-ingress stable/nginx-ingress`
2. Install prometheus `cd kubernetes/Charts/prometheus && helm3 upgrade prom . -f custom_values.yml --install`
3. Run reddit:

```bash
cd ..
helm3 upgrade reddit-test ./reddit --install
kubectl create namespace production
helm3 upgrade production -n production ./reddit --install
kubectl create namespace staging
helm3 upgrade staging --namespace staging ./reddit --install
```

4. Install grafana:

```bash
helm3 upgrade --install grafana stable/grafana --set "adminPassword=admin" \
--set "service.type=NodePort" \
--set "ingress.enabled=true" \
--set "ingress.hosts={reddit-grafana}"
```

5. Deploy EFK

```bash
helm3 repo add elastic https://helm.elastic.co
helm3 upgrade --install elasticsearch -f elasticsearch_custom_values.yaml elastic/elasticsearch
helm3 upgrade --install kibana -f kibana_custom_values.yaml elastic/kibana
helm3 upgrade --install fluentd -f fluentd_custom_values.yaml stable/fluentd
```
