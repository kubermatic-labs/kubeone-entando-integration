# Entando setup on K8s cluster using Kubeone

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
```
make k1-apply PROVIDER=aws
```
> Note, after deployement kindly update the value for "ingressHostName" inside addons/05_entando.yaml with DNS mapping for nginx ingress controller External IP. 


## Destroy the k8s cluster
```
make k1-reset PROVIDER=aws
```

## Destroy the AWS infrastructure
```
make k1-tf-destroy PROVIDER=aws
```