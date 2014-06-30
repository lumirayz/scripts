#!/bin/sh

if [ x"$1" = x"" ]; then
	echo "Usage: $0 user"
	exit -1
fi

USER=$1

mkdir /web/$USER/
chown $USER:web-data /web/$USER/
chmod 755 /web/$USER

cat > /web/config/${USER}.conf <<DOC
server {
    server_name CHANGEME;
    index index.html;
    listen 80;
    listen [::]:80;
    access_log /web/log/${USER}_access.log;
    error_log /web/log/${USER}_error.log;
    expires off;
    root /web/$USER/\$host/;
}
DOC
