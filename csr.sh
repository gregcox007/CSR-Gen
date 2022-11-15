#!/bin/bash

echo "CSR Generation Tool"
echo -n "What is the URL?"
read url

echo -n "What is the Country Code?"
read country

echo -n "What is the State or Province?"
read state

echo -n "What is the Locality Name?"
read locality

echo -n "What is the Organizational Name?"
read org

echo -n "What is the Organizational Unit (OU)?"
read ou

cat > san.cnf.orig << ENDOFFILE
[ req ]
default_bits       = 2048
distinguished_name = req_distinguished_name
req_extensions     = req_ext
prompt = no
[ req_distinguished_name ]
countryName                 = $country
stateOrProvinceName         = $state
localityName               = $locality
organizationName           = $org
OU                         = $ou
commonName                 = $url
[ req_ext ]
subjectAltName = @alt_names
[alt_names]
DNS.1 = $url
ENDOFFILE

openssl req -out "$url".csr -newkey rsa:2048 -nodes -keyout "$url".key -config san.cnf.orig
echo "Thank you for using the CSR Generation Tool."
