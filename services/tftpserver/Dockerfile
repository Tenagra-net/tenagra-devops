FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ "Etc\UTC"

RUN apt-get update && \
    apt-get install -y tftpd-hpa

EXPOSE 69
CMD /usr/sbin/in.tftpd --foreground --address 0.0.0.0:69 --secure /source