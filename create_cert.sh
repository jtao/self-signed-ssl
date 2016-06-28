#!/bin/sh
echo "Generate a Private Key"
openssl genrsa -des3 -out server.key 1024

echo "Generate a CSR (Certificate Signing Request)"
openssl req -new -key server.key -out server.csr < myinfo.txt

echo "Remove Passphrase from Key"
cp server.key server.key.org
openssl rsa -in server.key.org -out server.key

echo "Generating a Self-Signed Certificate"
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt

echo "Installing the Private Key and Certificate"
cp server.crt /etc/httpd/conf/server.crt
cp server.key /etc/httpd/conf/server.key
