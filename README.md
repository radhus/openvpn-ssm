# OpenVPN with configuration in SSM

This Docker image runs OpenVPN and fetches your server configuration from [AWS SSM Parameter Store](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-paramstore.html), including a helper to fetch client configurations from SSM as well.

## Usage

Create a configuration file, see [`example-server.conf`](example-server.conf). Upload this configuration file to SSM.

If you want to fetch client configuration files from SSM, include the following two lines in your server configuration:
```
client-connect /usr/bin/client-connect.sh
script-security 2
```

Upload any client configuration files to SSM under a base path, where each client certificate **common name** will be suffixed.

Run the `radhus/openvpn-ssm:latest` Docker image with the following environment variables:
* `SSM_SERVER_CONF` to the SSM path to the server configuration
* `SSM_CLIENT_PATH` to the SSM base path to find client configuration **(optional)**
* `SSM_SERVER_CERT` to the SSM server cert which will be stored at `/etc/openvpn/server.pem` **(optional)**
* `SSM_SERVER_KEY` to the SSM server private key which will be stored at `/etc/openvpn/server.key` **(optional)**
* `AWS_DEFAULT_REGION` to the AWS region used. Other AWS authentication variables may be needed for your use case.

## Example

Upload server configuration:

```shell
$ aws ssm put-parameter \
	--type String \
	--overwrite \
	--name "/vpn/server/conf" \
	--value "file://server.conf"
```

Upload client configuration:

```shell
$ aws ssm put-parameter \
	--type String \
	--overwrite \
	--name "/vpn/client/one_client_name" \
	--value "file://one_client_name.conf"
```

Run container, some flags may vary for your use case:

```shell
$ docker run \
    --rm 
    --cap-add NET_ADMIN \
    --device /dev/net/tun \
    --env AWS_DEFAULT_REGION=eu-north-1 \
    --env SSM_SERVER_CONF=/vpn/server/conf \
    --env SSM_CLIENT_PATH=/vpn/client/ \
    radhus/openvpn-ssm:latest
```