#!/bin/sh

# users
useradd web-data

# dirs
mkdir /web
mkdir /web/config
mkdir /web/log

# permissions
chown -R web-data /web
chmod 0775 /web
chmod 0700 /web/config
chmod 0770 /web/log

# config
cat >/etc/nginx/nginx.conf <<DOC
user web-data;
worker_processes 4;

events {
    worker_connections  1024;
}

http {
    sendfile    on;
    tcp_nopush  on;
    tcp_nodelay on;
    gzip        on;

    keepalive_timeout 65;

    types_hash_max_size 2048;

    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    access_log /web/log/access.log;

    include /web/config/*.conf;
}
DOC
