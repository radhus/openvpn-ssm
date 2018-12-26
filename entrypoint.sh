#!/bin/sh

set -e

test -n "${SSM_SERVER_CONF}"
test -n "${SSM_CLIENT_PATH}"

server_conf="/etc/openvpn/server.conf"
download-ssm.sh "${SSM_SERVER_CONF}" "${server_conf}"

[ "${SSM_SERVER_CERT}" == "" ] || download-ssm.sh "${SSM_SERVER_CERT}" "/etc/openvpn/server.pem"
[ "${SSM_SERVER_KEY}" == "" ]  || download-ssm.sh "${SSM_SERVER_KEY}"  "/etc/openvpn/server.key"

echo "Starting OpenVPN ..."
exec /usr/sbin/openvpn --config "${server_conf}"
