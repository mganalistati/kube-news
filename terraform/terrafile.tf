module "cluster" {
  source = "./do_cluster"

  # Inputs to the cluster ;
  do_cluster_name    = "kubedev-io"
  do_cluster_region  = "nyc1"
  do_cluster_version = "1.25.4-do.0"

  # Inputs to the pool ;
  do_pool_name       = "kubedev-io-pool"
  do_pool_size       = "s-2vcpu-2gb"
  do_pool_node_count = 3
}

resource "local_file" "kube_config" {
  content  = module.cluster.kube_config
  filename = "kube_config.yaml"
}