locals {
  generate_password   = var.basic_auth_password == null || var.basic_auth_password == ""
  basic_auth_user     = var.basic_auth_user
  basic_auth_password = local.generate_password ? random_password.faasd[0].result : var.basic_auth_password

  user_data_vars = {
    basic_auth_user     = local.basic_auth_user
    basic_auth_password = local.basic_auth_password
    domain              = var.domain
    email               = var.email
  }
}

resource "random_password" "faasd" {
  count   = local.generate_password ? 1 : 0
  length  = 16
  special = false
}

resource "digitalocean_droplet" "faasd" {
  name     = var.name
  image    = "ubuntu-20-04-x64"
  region   = var.region
  size     = var.droplet_size
  ssh_keys = var.ssh_keys
  tags     = ["faasd", var.name]
  vpc_uuid = var.vpc_uuid

  user_data = templatefile("${path.module}/templates/startup.sh", local.user_data_vars)
}

resource "digitalocean_firewall" "faasd" {
  name = var.name

  droplet_ids = [digitalocean_droplet.faasd.id]

  dynamic "inbound_rule" {
    for_each = var.domain == "" ? [1] : []
    content {
      protocol         = "tcp"
      port_range       = "8080"
      source_addresses = ["0.0.0.0/0", "::/0"]
    }
  }

  dynamic "inbound_rule" {
    for_each = var.domain != "" ? [1] : []
    content {
      protocol         = "tcp"
      port_range       = "80"
      source_addresses = ["0.0.0.0/0", "::/0"]
    }
  }

  dynamic "inbound_rule" {
    for_each = var.domain != "" ? [1] : []
    content {
      protocol         = "tcp"
      port_range       = "443"
      source_addresses = ["0.0.0.0/0", "::/0"]
    }
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "all"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "all"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

}