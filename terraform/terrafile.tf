module "cluster-self-managed" {
  source = "./do_cluster"

  # Inputs to the cluster ;
  do_cluster_name    = "kubedev-io"
  do_cluster_region  = "nyc1"
  do_cluster_version = "1.25.4-do.0"

  # Inputs to the pool ;
  do_pool_name       = "kubedev-io-pool"
  do_pool_size       = "s-2vcpu-2gb"
  do_pool_node_count = 2
}

resource "local_file" "kube_config" {
  content  = module.cluster-self-managed.kube_config
  filename = "kube_config.yaml"
}

module "jenkins-self-hosted" {
  source = "./do_droplet"

  # Inputs to the droplet ;
  do_droplet_image  = "ubuntu-18-04-x64"
  do_droplet_name   = "jenkins-self-hosted"
  do_droplet_region = "nyc1"
  do_droplet_size   = "s-2vcpu-2gb"
  do_droplet_ssh_key = "key-droplete-jekins"
}