cluster_name                       = "entando-demo"
ssh_public_key_file                = "/path/to/.ssh/id_rsa.pub"
ssh_private_key_file               = "/path/to/.ssh/id_rsa"
ssh_username                       = "ubuntu"
initial_machinedeployment_replicas = 1
control_plane_vm_count             = 1
static_workers_count               = 0
worker_os                          = "ubuntu"
aws_region                         = "eu-central-1"
# More variables can be overridden here, see variables.tf.
