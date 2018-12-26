#!/bin/sh

set -e

ssm_path=$1
test -n "${ssm_path}"

file_path=$2
test -n "${file_path}"

echo "Downloading ${ssm_path} to ${file_path} ..."

aws ssm get-parameter \
    --with-decryption \
    --output text \
    --query Parameter.Value \
    --name "${ssm_path}" \
    > "${file_path}"
chmod 0400 "${file_path}"