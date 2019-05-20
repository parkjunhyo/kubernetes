#! /usr/bin/env bash


cat << EOF > ./.sample.pem
-----BEGIN RSA PRIVATE KEY-----
-----END RSA PRIVATE KEY-----
EOF
chmod 400 ./.sample.pem
