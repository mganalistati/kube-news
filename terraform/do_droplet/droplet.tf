data "digitalocean_ssh_key" "jenkins_key" {
  name = var.do_droplet_ssh_key
}

resource "digitalocean_droplet" "jenkins" {
  image  = var.do_droplet_image
  name   = var.do_droplet_name
  region = var.do_droplet_region
  size   = var.do_droplet_size
 
  ssh_keys = [data.digitalocean_ssh_key.jenkins_key.id]
}