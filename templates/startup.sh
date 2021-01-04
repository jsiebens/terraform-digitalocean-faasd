#! /bin/bash

mkdir -p /var/lib/faasd/secrets/
echo ${gw_password} > /var/lib/faasd/secrets/basic-auth-password
echo admin > /var/lib/faasd/secrets/basic-auth-user

export FAASD_DOMAIN=${faasd_domain}
export LETSENCRYPT_EMAIL=${letsencrypt_email}

curl -sfL https://raw.githubusercontent.com/openfaas/faasd/master/hack/install.sh | sh -s -