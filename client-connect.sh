#!/bin/sh

set -e

config="$1"
test -n "${config}"

# environment variables
test -n "${SSM_CLIENT_PATH}"
test -n "${common_name}"

# join paths
root=$(echo "${SSM_CLIENT_PATH}" | sed -e 's#/*$##g')
file=$(echo "${common_name}" | sed -e 's#^/*##g')
ssm_path="${root}/${file}"

download-ssm.sh "${ssm_path}" "${config}"
