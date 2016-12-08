FROM ubuntu:xenial

ARG ADMIN_PASSWORD

MAINTAINER Ushmodin Nikolay <ushmodin@gmail.com>

RUN apt-get update && \
    apt-get install -y rabbitmq-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rabbitmq-plugins enable rabbitmq_management

RUN mkdir /etc/rabbitmq/keys
ADD rabbitmq.config /etc/rabbitmq/rabbitmq.config
ADD ca.crt rabbitmq.crt rabbitmq.key /etc/rabbitmq/keys/

VOLUME /var/lib/rabbitmq
EXPOSE 5672 5671 15672
ENV ADMIN_PASSWORD ${ADMIN_PASSWORD}

CMD chown rabbitmq:rabbitmq /var/lib/rabbitmq && \
    service rabbitmq-server start && \
    rabbitmqctl add_user admin $ADMIN_PASSWORD && \
    rabbitmqctl set_user_tags admin administrator && \
    rabbitmqctl set_permissions -p / admin ".*" ".*" ".*" && \
    service rabbitmq-server stop && \
    /usr/sbin/rabbitmq-server

