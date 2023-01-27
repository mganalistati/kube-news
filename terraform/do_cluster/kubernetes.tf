resource "digitalocean_kubernetes_cluster" "kubedev" {
  name   = var.do_cluster_name
  
  region = var.do_cluster_region
  version = var.do_cluster_version

  node_pool {
    name       = var.do_pool_name
    size       = var.do_pool_size
    node_count = var.do_pool_node_count
  }
}

