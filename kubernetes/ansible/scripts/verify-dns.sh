# Create a busybox deployment:

kubectl run --generator=run-pod/v1 busybox --image=busybox:1.28 --command -- sleep 3600

# List the pod created by the busybox deployment:

kubectl get pods -l run=busybox

# output

# NAME      READY   STATUS    RESTARTS   AGE
# busybox   1/1     Running   0          3s

# Retrieve the full name of the busybox pod:

POD_NAME=$(kubectl get pods -l run=busybox -o jsonpath="{.items[0].metadata.name}")

# Execute a DNS lookup for the kubernetes service inside the busybox pod:

kubectl exec -ti $POD_NAME -- nslookup kubernetes
