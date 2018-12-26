FROM alpine:latest

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk add --no-cache \
        aws-cli \
        openvpn

WORKDIR /etc/openvpn

COPY --chown=root:root \
    client-connect.sh \
    download-ssm.sh \
    entrypoint.sh \
    /usr/bin/

ENTRYPOINT /usr/bin/entrypoint.sh