locals {
  faasd_domain = var.domain == null || var.domain == "" ? "" : format("%s.%s", var.subdomain, var.domain)
}

resource "random_password" "admin" {
  length  = 16
  special = false
}

data "template_file" "faasd" {
  template = file("${path.module}/templates/startup.sh")
  vars = {
    gw_password       = random_password.admin.result
    faasd_domain      = local.faasd_domain
    letsencrypt_email = var.letsencrypt_email
  }
}

resource "digitalocean_droplet" "faasd" {
  name      = var.name
  image     = "ubuntu-18-04-x64"
  region    = var.region
  size      = var.droplet_size
  ssh_keys  = var.ssh_keys
  user_data = data.template_file.faasd.rendered
  tags      = ["faasd"]
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

  dynamic "inbound_rule" {
    for_each = var.ssh_allowed ? [1] : []
    content {
      protocol         = "tcp"
      port_range       = "22"
      source_addresses = ["0.0.0.0/0", "::/0"]
    }
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

resource "digitalocean_record" "faasd" {
  count  = var.create_dns_record == true ? 1 : 0
  domain = var.domain
  type   = "A"
  name   = var.subdomain
  value  = digitalocean_droplet.faasd.ipv4_address
}