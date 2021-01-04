terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
  required_version = ">= 0.13"
}

variable "do_token" {
  description = "Digitalocean API token"
}

variable "ssh_key_file" {
  default     = "~/.ssh/id_rsa.pub"
  description = "Path to the SSH public key file"
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_ssh_key" "faasd" {
  name       = "faasd"
  public_key = file(var.ssh_key_file)
}

module "faasd" {
  source = "../"

  region   = "lon1"
  ssh_keys = [digitalocean_ssh_key.faasd.id]
}