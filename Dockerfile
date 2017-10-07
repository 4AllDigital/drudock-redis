FROM phusion/baseimage
MAINTAINER 4 All Digital  "joe@4alldigital.com"

ENV DEBIAN_FRONTEND noninteractive

# Ensure UTF-8
RUN locale-gen en_GB.UTF-8
ENV LANG       en_GB.UTF-8
ENV LC_ALL     en_GB.UTF-8

RUN apt-get update && \
    apt-get install -y redis-server && \
    apt-get clean all && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /tmp/db

COPY ./config/redis.conf /etc/redis/redis.conf

RUN ln -sf /dev/stdout /var/log/redis/redis-server.log

EXPOSE 6380 6379

ENTRYPOINT  ["/usr/bin/redis-server", "/etc/redis/redis.conf"]
