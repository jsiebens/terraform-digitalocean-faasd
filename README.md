# faasd for DigitalOcean

This repo contains a Terraform Module for how to deploy a [faasd](https://github.com/openfaas/faasd) instance on
[DigitalOcean](https://digitalocean.com/) using [Terraform](https://www.terraform.io/).

__faasd__, a lightweight & portable faas engine, is [OpenFaaS](https://github.com/openfaas/) reimagined, but without the cost and complexity of Kubernetes. It runs on a single host with very modest requirements, making it fast and easy to manage. Under the hood it uses [containerd](https://containerd.io/) and [Container Networking Interface (CNI)](https://github.com/containernetworking/cni) along with the same core OpenFaaS components from the main project.

## What's a Terraform Module?

A Terraform Module refers to a self-contained packages of Terraform configurations that are managed as a group. This repo
is a Terraform Module and contains many "submodules" which can be composed together to create useful infrastructure patterns.

## How do you use this module?

This repository defines a [Terraform module](https://www.terraform.io/docs/modules/usage.html), which you can use in your
code by adding a `module` configuration and setting its `source` parameter to URL of this repository:

```hcl
module "faasd" {
  source = "github.com/jsiebens/terraform-digitalocean-faasd"
  
  name     = "faasd"
  region   = "lon1"
  ssh_keys = [12345, 123456]
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| digitalocean | >= 2.11.0 |
| random | >= 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| digitalocean | >= 2.11.0 |
| random | >= 3.1.0 |

## Resources

| Name | Type |
|------|------|
| [digitalocean_droplet.faasd](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet) | resource |
| [digitalocean_firewall.faasd](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/firewall) | resource |
| [random_password.faasd](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| basic\_auth\_password | The basic auth password, if left empty, a random password is generated. | `string` | `null` | no |
| basic\_auth\_user | The basic auth user name. | `string` | `"admin"` | no |
| domain | A public domain for the faasd instance. This will the use of Caddy and a Let's Encrypt certificate | `string` | `""` | no |
| droplet\_size | The droplet size to use for the faasd instance (e.g. s-1vcpu-1gb). | `string` | `"s-1vcpu-1gb"` | no |
| email | Email used to order a certificate from Let's Encrypt | `string` | `""` | no |
| name | The name of the faasd instance. All resources will be namespaced by this value. | `string` | n/a | yes |
| region | The region in which all DigitalOcean resources will be launched. | `string` | `"lon1"` | no |
| ssh\_keys | A list of SSH IDs or fingerprints to enable on the faasd droplet | `list(string)` | `[]` | no |
| vpc\_uuid | The ID of the VPC where the Droplet will be located. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| basic\_auth\_password | The basic auth password. |
| basic\_auth\_user | The basic auth user name. |
| gateway\_url | The url of the faasd gateway |
| ipv4\_address | The public IP address of the faasd droplet |
<!-- END_TF_DOCS -->

## See Also

- [faasd on Google Cloud Platform with Terraform](https://github.com/jsiebens/terraform-google-faasd)
- [faasd on Microsoft Azure with Terraform](https://github.com/jsiebens/terraform-azurerm-faasd)
- [faasd on DigitalOcean with Terraform](https://github.com/jsiebens/terraform-digitalocean-faasd)
- [faasd on Equinix Metal with Terraform](https://github.com/jsiebens/terraform-equinix-faasd)
- [faasd on Scaleway with Terraform](https://github.com/jsiebens/terraform-scaleway-faasd)
