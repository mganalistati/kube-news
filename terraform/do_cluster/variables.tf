variable "do_cluster_name" {
    description = "A name for the Kubernetes cluster (String)"
    type = string
    default = "my-cluster"
}

variable "do_cluster_region" {
    description = "The slug identifier for the region where the Kubernetes cluster will be created (String)"
    type = string
    sensitive = true
}

variable "do_cluster_version" {
    description = "The slug identifier for the version of Kubernetes used for the cluster (String)"
    type = string
}

variable "do_pool_name" {
    description = "A name for the node pool (String)"
    type  = string
    default = "worker-pool"
}

variable "do_pool_size" {
    description = "The slug identifier for the type of Droplet to be used as workers in the node pool (String)"
    type  = string
    default = "s-2vcpu-2gb"
}

variable "do_pool_node_count" {
    description = "The number of Droplet instances in the node pool (String)"
    type  = number
    default = 3
}