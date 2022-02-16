# Entando setup on K8s cluster using Kubeone

## Clone the repository
```bash
git clone https://github.com/kubermatic-labs/kubeone-entando-integration.git
cd kubeone-entando-integration
```

## Configure the Enviornment
```
export AWS_ACCESS_KEY_ID=xxxxxxxxxxxxxxx
export AWS_SECRET_ACCESS_KEY=xxxxxxxxxxxxxxxxxxxx
```

## Create Infrasture using Terraform
```
eval `ssh-agent`
ssh-add /path/to/.ssh/id_rsa
make k1-tf-apply PROVIDER=aws
```
> Update the terraform.tfvars for keys and k8s configuration changes

## Create k8s cluster using kubeone along with Entando deployment as addon.
> Note, before deployement kindly update the $ENTANDO_DNS value for "ingressHostName" inside `aws/addons/entando/05_entando.yaml` file.
```
export ENTANDO_DNS=xxx.xxx.xxx.xxx
sed -i 's/TODO_DNS/'"$ENTANDO_DNS"'/g' ./aws/addons/entando/05_entando.yaml
make k1-apply PROVIDER=aws
```

## Verify and access the Entando

* Update DNS mapping($ENTANTDO_DNS) with External IP of the nginx ingress controller service. In case of AWS, the CNAME record mapping for $ENTANDO_DNS with External IP should be created.
  ```bash
  kubectl get svc -n ingress-nginx
  ```
  > External IP from the output should be used for CNAME record mapping.

* Verify the pods inside entando namespace
  ```bash
  kubectl get pods -n entando -w
  ```
  Once all the pods are up and running, output of `kubectl get pods -n entando` will be as follows
  ```bash
  NAME                                              READY   STATUS    RESTARTS   AGE
  entando-ab-deployment-5f5f4d9c89-fjfrv            1/1     Running   0          3m41s
  entando-cm-deployment-57cd7b47fd-rbzth            1/1     Running   0          3m9s
  entando-eci-k8s-svc-deployment-656cdc47df-prgqz   1/1     Running   0          7m9s
  entando-kc-server-deployment-5fcc67558c-j7qmd     1/1     Running   0          9m19s
  entando-operator-78d5c6df4d-6rt7f                 1/1     Running   0          13m
  entando-server-deployment-6dd75dbdf5-kprpb        1/1     Running   0          6m18s
  ```

* Finally, login to the Entando using https://$ENTANDO_DNS/app-builder/ from the browser.


## Destroy the k8s cluster
```
make k1-reset PROVIDER=aws
```

## Destroy the AWS infrastructure
```
make k1-tf-destroy PROVIDER=aws
```