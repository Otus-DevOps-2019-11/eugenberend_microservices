for service in mongo comment post ui; do
  kubectl apply -f ${service}-deployment.yml
done
