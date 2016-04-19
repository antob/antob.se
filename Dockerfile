FROM alpine:3.2
MAINTAINER Tobias Lindholm <tob@antob.se>

RUN apk add --update openssh-client git tar

RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.0.1/dumb-init_1.0.1_amd64 \
    && chmod +x /usr/local/bin/dumb-init

RUN curl --silent --show-error --fail --location \
      --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
      "https://caddyserver.com/download/build?os=linux&arch=amd64&features=git" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy \
 && chmod 0755 /usr/bin/caddy \
 && /usr/bin/caddy -version

EXPOSE 80 443
VOLUME /srv
WORKDIR /srv

ADD Caddyfile /etc/Caddyfile

ENTRYPOINT ["dumb-init", "/usr/bin/caddy"]
CMD ["--conf", "/etc/Caddyfile"]
