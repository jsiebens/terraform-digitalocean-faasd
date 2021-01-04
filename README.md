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

  region     = "lon1"
  ssh_keys   = [12345, 123456]
}
```

<!-- TERRAFORM-DOC:START -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| digitalocean | >= 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| digitalocean | >= 2.2.0 |
| random | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| create\_dns\_record | When set to true, a new DNS record will be created. This works only if your domain (domain) is managed by Digitalocean | `bool` | `false` |
| domain | A public domain for the faasd instance. This will the use of Caddy and a Let's Encrypt certificate | `string` | `""` |
| droplet\_size | The droplet size to use for the faasd instance (e.g. s-1vcpu-1gb). | `string` | `"s-1vcpu-1gb"` |
| letsencrypt\_email | Email used to order a certificate from Let's Encrypt | `string` | `""` |
| name | The name of the faasd instance. All resources will be namespaced by this value. | `string` | `"faasd"` |
| region | The region in which all DigitalOcean resources will be launched. | `string` | `"lon1"` |
| ssh\_allowed | Allow SSH connections to the faasd instance | `bool` | `true` |
| ssh\_keys | A list of SSH IDs or fingerprints to enable on the faasd droplet | `list(string)` | `[]` |
| subdomain | A public subdomain for the faasd instance. | `string` | `"faasd"` |

## Outputs

| Name | Description |
|------|-------------|
| gateway\_url | The url of the faasd gateway |
| instance\_ip | The public IP address of the faasd droplet |
| login\_cmd | The complete command to authenticate with the faas-cli |
| password | The admin password |
<!-- TERRAFORM-DOC:START -->