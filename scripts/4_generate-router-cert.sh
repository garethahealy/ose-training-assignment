#!/usr/bin/env bash

# https://help.github.com/enterprise/11.10.340/admin/articles/using-self-signed-ssl-certificates/
rm -rf /root/certs
mkdir /root/certs
cd /root/certs

openssl genrsa -out router-ca.key 2048
openssl req -x509 -new -nodes -key router-ca.key -days 365 -out router-ca.crt -subj '/C=UK/ST=Yorkshire/L=Sheffield/CN=*.oslab.opentlc.com'

openssl genrsa -out router.key 2048
openssl req -new -key router.key -out router.csr -subj '/C=UK/ST=Yorkshire/L=Sheffield/CN=*.oslab.opentlc.com'
openssl x509 -req -in router.csr -CA router-ca.crt -CAkey router-ca.key -CAcreateserial -out router.crt -days 365
