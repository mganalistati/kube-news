variable "do_droplet_image" {
    description = "The Droplet image ID or slug. This could be either image ID or droplet snapshot ID"
    type = string
    default = "ubuntu-18-04-x64"
}

variable "do_droplet_name" {
    description = "The Droplet name"
    type = string
    default = "jenkins-self-hosted"
}

variable "do_droplet_region" {
    description = "The region where the Droplet will be created"
    type = string
    default = "nyc1"
    sensitive = true
}

variable "do_droplet_size" {
    description = "The unique slug that indentifies the type of Droplet"
    type = string
    default = "s-2vcpu-2gb"
}

variable "do_droplet_ssh_key" {
  description = "The name of the ssh key"
  type = string
  sensitive =  true
}