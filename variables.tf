variable region {
  description = "The region in which all DigitalOcean resources will be launched."
  type        = string
  default     = "lon1"
}

variable droplet_size {
  description = "The droplet size to use for the faasd instance (e.g. s-1vcpu-1gb)."
  type        = string
  default     = "s-1vcpu-1gb"
}

variable ssh_allowed {
  description = "Allow SSH connections to the faasd instance"
  type        = bool
  default     = true
}

variable ssh_keys {
  description = "A list of SSH IDs or fingerprints to enable on the faasd droplet"
  type        = list(string)
  default     = []
}

variable name {
  description = "The name of the faasd instance. All resources will be namespaced by this value."
  type        = string
  default     = "faasd"
}

variable domain {
  description = "A public domain for the faasd instance. This will the use of Caddy and a Let's Encrypt certificate"
  type        = string
  default     = ""
}

variable subdomain {
  description = "A public subdomain for the faasd instance."
  type        = string
  default     = "faasd"
}

variable letsencrypt_email {
  description = "Email used to order a certificate from Let's Encrypt"
  type        = string
  default     = ""
}

variable create_dns_record {
  description = "When set to true, a new DNS record will be created. This works only if your domain (domain) is managed by Digitalocean"
  type        = bool
  default     = false
}