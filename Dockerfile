FROM nginx
MAINTAINER Tobias Lindholm <tob@antob.se>

COPY public /usr/share/nginx/html

EXPOSE 80
