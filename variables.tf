variable "name" {
  description = "The name of the faasd instance. All resources will be namespaced by this value."
  type        = string
}

variable "basic_auth_user" {
  description = "The basic auth user name."
  type        = string
  default     = "admin"
}

variable "basic_auth_password" {
  description = "The basic auth password, if left empty, a random password is generated."
  type        = string
  default     = null
  sensitive   = true
}

variable "domain" {
  description = "A public domain for the faasd instance. This will the use of Caddy and a Let's Encrypt certificate"
  type        = string
  default     = ""
}

variable "email" {
  description = "Email used to order a certificate from Let's Encrypt"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A list of the tags to be applied to this Droplet."
  type        = list(string)
  default     = ["faasd"]
}

variable "region" {
  description = "The region in which all DigitalOcean resources will be launched."
  type        = string
  default     = "lon1"
}

variable "vpc_uuid" {
  description = "The ID of the VPC where the Droplet will be located."
  type        = string
  default     = null
}

variable "droplet_size" {
  description = "The droplet size to use for the faasd instance (e.g. s-1vcpu-1gb)."
  type        = string
  default     = "s-1vcpu-1gb"
}

variable "ssh_keys" {
  description = "A list of SSH IDs or fingerprints to enable on the faasd droplet"
  type        = list(string)
  default     = []
}
