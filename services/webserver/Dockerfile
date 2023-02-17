FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ "Etc\UTC"

RUN apt-get update && \
    apt-get install -y nginx

RUN rm -rf /var/www/html/*
COPY default /etc/nginx/sites-enabled/default

EXPOSE 80
CMD /usr/sbin/nginx -g 'daemon off;'