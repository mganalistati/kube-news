## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | ~> 2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [digitalocean_kubernetes_cluster.kubedev](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/kubernetes_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_do_cluster_name"></a> [do\_cluster\_name](#input\_do\_cluster\_name) | A name for the Kubernetes cluster | `string` | `"my-cluster"` | no |
| <a name="input_do_cluster_region"></a> [do\_cluster\_region](#input\_do\_cluster\_region) | The slug identifier for the region where the Kubernetes cluster will be created | `string` | n/a | yes |
| <a name="input_do_cluster_version"></a> [do\_cluster\_version](#input\_do\_cluster\_version) | The slug identifier for the version of Kubernetes used for the cluster | `string` | n/a | yes |
| <a name="input_do_pool_name"></a> [do\_pool\_name](#input\_do\_pool\_name) | A name for the node pool | `string` | `"worker-pool"` | no |
| <a name="input_do_pool_node_count"></a> [do\_pool\_node\_count](#input\_do\_pool\_node\_count) | The number of Droplet instances in the node pool | `number` | `3` | no |
| <a name="input_do_pool_size"></a> [do\_pool\_size](#input\_do\_pool\_size) | The slug identifier for the type of Droplet to be used as workers in the node pool | `string` | `"s-2vcpu-2gb"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kube_config"></a> [kube\_config](#output\_kube\_config) | n/a |
