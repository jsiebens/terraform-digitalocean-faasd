output "instance_ip" {
  description = "The public IP address of the faasd droplet"
  value = digitalocean_droplet.faasd.ipv4_address
}

output "gateway_url" {
  description = "The url of the faasd gateway"
  value = var.domain == null || var.domain == "" ? format("http:/%s:8080", digitalocean_droplet.faasd.ipv4_address) : format("https://%s", local.faasd_domain)
}

output "password" {
  description = "The admin password"
  value = random_password.admin.result
}

output "login_cmd" {
  description = "The complete command to authenticate with the faas-cli"
  value = var.domain == null || var.domain == "" ? format("faas-cli login -g http:/%s:8080 -p %s", digitalocean_droplet.faasd.ipv4_address, random_password.admin.result) : format("faas-cli login -g https:/%s -p %s", local.faasd_domain, random_password.admin.result)
}
