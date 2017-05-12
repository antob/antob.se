FROM alpine:3.5
MAINTAINER Tobias Lindholm <tob@antob.se>

RUN apk add --update --no-cache openssh-client openssl git tar ca-certificates curl \
	&& update-ca-certificates

RUN curl --silent --show-error --fail --location \
      --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
      "https://caddyserver.com/download/linux/amd64?plugins=http.git" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy \
 && chmod 0755 /usr/bin/caddy \
 && /usr/bin/caddy -version

EXPOSE 80 443

ADD Caddyfile /etc/Caddyfile

ENTRYPOINT ["/usr/bin/caddy", "-conf", "/etc/Caddyfile"]
