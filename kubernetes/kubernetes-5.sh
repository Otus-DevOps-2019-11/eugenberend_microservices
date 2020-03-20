# Provide a cluster from GUI

# Add stable repo
helm3 repo add stable https://kubernetes-charts.storage.googleapis.com
helm3 repo update

# Install ingress
helm3 install nginx-ingress stable/nginx-ingress

# Get IP to add to /etc/hosts
kubectl get svc

# Load prometheus repo
cd kubernetes/Charts
helm3 fetch --untar stable/prometheus

# Create custom_value.yaml
cd prometheus
wget https://gist.githubusercontent.com/chromko/2bd290f7becdf707cde836ba1ea6ec5c/raw/c17372866867607cf4a0445eb519f9c2c377a0ba/gistfile1.txt -O custom_values.yml

# Run prometheus upgrade
# That will produce some warnings like:
# coalesce.go:196: warning: cannot overwrite table with non table for alertmanager.yml bla bla bla
# You can safely ignore this
helm3 upgrade prom . -f custom_values.yml --install

# Turn on kubeStateMetrics (manually)

# Run prometheus upgrade again
helm3 upgrade prom . -f custom_values.yml --install

# Turn on nodeExporter (manually)

# Run prometheus upgrade again
helm3 upgrade prom . -f custom_values.yml --install

# The endpoint http://10.166.0.23:9100/metrics may going up with some delay, so no panic there

# Run reddit
cd ..
helm3 upgrade reddit-test ./reddit --install
kubectl create namespace production
helm3 upgrade production -n production ./reddit --install
kubectl create namespace staging
helm3 upgrade staging --namespace staging ./reddit --install

# Add job_name manually:
#       - job_name: 'reddit-endpoints'
#         kubernetes_sd_configs:
#         - role: endpoints
#         relabel_configs:
#         - source_labels: [__meta_kubernetes_service_label_app]
#           action: keep
#           regex: reddit

# Run prometheus upgrade again
cd prometheus
helm3 upgrade prom . -f custom_values.yml --install

# Insert into LAST job between relabel_configs and source_labels
#         - action: labelmap # Отобразить все совпадения групп
#           regex: __meta_kubernetes_service_label_(.+)

# Run prometheus upgrade again
helm3 upgrade prom . -f custom_values.yml --install

# Than, refresh prometheus web page multiple times

# Than, add to the end of last relabel_configs

        # - source_labels: [__meta_kubernetes_namespace]
        #   target_label: kubernetes_namespace
        # - source_labels: [__meta_kubernetes_service_name]
        #   target_label: kubernetes_name

# Run prometheus upgrade again
helm3 upgrade prom . -f custom_values.yml --install

# Add new job
# - job_name: 'reddit-production'
#    kubernetes_sd_configs:
#      - role: endpoints
#    relabel_configs:
#      - action: labelmap
#        regex: __meta_kubernetes_service_label_(.+)
#      - source_labels: [__meta_kubernetes_service_label_app, __meta_kubernetes_namespace]
#        action: keep
#        regex: reddit;(production|staging)+
#      - source_labels: [__meta_kubernetes_namespace]
#        target_label: kubernetes_namespace
#      - source_labels: [__meta_kubernetes_service_name]
#        target_label: kubernetes_name

# Run prometheus upgrade again
helm3 upgrade prom . -f custom_values.yml --install

# Replace reddit_endpoints job
#       - job_name: 'post-endpoints'
#         kubernetes_sd_configs:
#           - role: endpoints
#         relabel_configs:
#           - source_labels: [__meta_kubernetes_service_label_component]
#             action: keep
#             regex: post
#           - action: labelmap
#             regex: __meta_kubernetes_service_label_(.+)
#           - source_labels: [__meta_kubernetes_namespace]
#             target_label: kubernetes_namespace
#           - source_labels: [__meta_kubernetes_service_name]
#             target_label: kubernetes_name

#       - job_name: 'comment-endpoints'
#         kubernetes_sd_configs:
#           - role: endpoints
#         relabel_configs:
#           - source_labels: [__meta_kubernetes_service_label_component]
#             action: keep
#             regex: comment
#           - action: labelmap
#             regex: __meta_kubernetes_service_label_(.+)
#           - source_labels: [__meta_kubernetes_namespace]
#             target_label: kubernetes_namespace
#           - source_labels: [__meta_kubernetes_service_name]
#             target_label: kubernetes_name

#       - job_name: 'ui-endpoints'
#         kubernetes_sd_configs:
#           - role: endpoints
#         relabel_configs:
#           - source_labels: [__meta_kubernetes_service_label_component]
#             action: keep
#             regex: ui
#           - action: labelmap
#             regex: __meta_kubernetes_service_label_(.+)
#           - source_labels: [__meta_kubernetes_namespace]
#             target_label: kubernetes_namespace
#           - source_labels: [__meta_kubernetes_service_name]
#             target_label: kubernetes_name

# Install grafana
helm3 upgrade --install grafana stable/grafana --set "adminPassword=admin" \
--set "service.type=NodePort" \
--set "ingress.enabled=true" \
--set "ingress.hosts={reddit-grafana}"

# Show prometheus url
kubectl get svc

# Add it to grafana datasource
# Import 315 dashboard
# Play with graphs
# Import 741 dashboard

# View big node
kubectl get nodes | grep big
# Assign label
kubectl label node *big* elastichost=true
# Create directory and files
cd ~/eugenberend_microservices/kubernetes
mkdir -p efk
cd efk
wget https://gist.githubusercontent.com/chromko/0716d4e792bddf73207febde0bbc4829/raw/5d37b85072351b02af3f912ae33ec284686e91ac/gistfile1.txt -O fluentd-ds.yaml
wget https://gist.githubusercontent.com/chromko/ed0a40317ff3cbd50dd9657efb480d48/raw/ac059f663078a9c7811038af96fe2b34ed21b708/gistfile1.txt -O fluentd-configmap.yaml
wget https://gist.githubusercontent.com/chromko/dadfe61ea89339c324de21b3985e7537/raw/c55f949b7c347957e723cd402d75410720efc068/gistfile1.txt -O es-service.yaml
wget https://gist.githubusercontent.com/chromko/b250ae034b16a0dadf7beb776d6a41a2/raw/d2caaf0560d65a5089a1769a9e6e31e72ae06892/gistfile1.txt -O es-statefulSet.yaml
wget https://gist.githubusercontent.com/chromko/8a3b3e6ee88a946fe59aad2090df457f/raw/c52a4a8f0f0e3e174c28df13475d3a90bd1d0fbe/gistfile1.txt -O es-pvc.yaml

# Deploy efk
cd ..
kubectl apply -f ./efk

# Deploy kibana
helm3 upgrade --install kibana stable/kibana \
--set "ingress.enabled=true" \
--set "ingress.hosts={reddit-kibana}" \
--set "env.ELASTICSEARCH_URL=http://elasticsearch-logging:9200" \
--version 0.1.1

# It fails. Deploy cool EFK from chart:
cd Charts
mkdir custom_efk && cd custom_efk

# Install EFK
helm3 repo add elastic https://helm.elastic.co
helm3 upgrade --install elasticsearch -f elasticsearch_custom_values.yaml elastic/elasticsearch
helm3 upgrade --install kibana -f kibana_custom_values.yaml elastic/kibana
helm3 upgrade --install fluentd -f fluentd_custom_values.yaml stable/fluentd
