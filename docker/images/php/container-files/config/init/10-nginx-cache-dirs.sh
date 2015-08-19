#!/bin/sh

#
# This script will be placed in /config/init/ and run when container starts.
# It creates (if they're not exist yet) necessary Nginx directories
# @see /etc/nginx/addon.d/fastcgi-cache.example
#

set -e

mkdir -p /run/user/nginx-cache
mkdir -p /run/user/nginx-cache-tmp
chown -R www:www /run/user/nginx-cache*

: "${MYSQL_PORT_3306_TCP_ADDR:=foo}"

echo fastcgi_param MYSQL_PORT_3306_TCP_ADDR $MYSQL_PORT_3306_TCP_ADDR';' >> /etc/nginx/fastcgi_params
echo fastcgi_param RDS_HOSTNAME $RDS_HOSTNAME';' >> /etc/nginx/fastcgi_params
echo fastcgi_param RDS_DB_NAME $RDS_DB_NAME';' >> /etc/nginx/fastcgi_params
echo fastcgi_param RDS_PASSWORD $RDS_PASSWORD';' >> /etc/nginx/fastcgi_params
echo fastcgi_param RDS_USERNAME $RDS_USERNAME';' >> /etc/nginx/fastcgi_params
echo fastcgi_param RDS_PORT $RDS_PORT';' >> /etc/nginx/fastcgi_params