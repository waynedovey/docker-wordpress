## CENTOS 7 + SUPERVISOR
FROM million12/centos-supervisor:latest

ADD . /var/www

## NGINX
RUN \
    rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm && \
    yum install -y nginx && \
    yum clean all && \
    groupmod --gid 80 --new-name www nginx && \
    usermod --uid 80 --home /data/www --gid 80 --login www --shell /bin/bash --comment www nginx && \
    rm -rf /etc/nginx/*.d /etc/nginx/*_params

## PHP + FPM
RUN \
    yum install -y yum-utils && \
    rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm && \
    yum-config-manager -q --enable remi && \
    yum-config-manager -q --enable remi-php56 && \
    yum install -y php-fpm php-bcmath php-cli php-gd php-intl php-mbstring php-mcrypt php-mysql php-opcache php-pdo && \
    yum install -y --disablerepo=epel php-pecl-redis php-pecl-yaml && \
    yum clean all

ENV RDS_HOSTNAME foo
ENV RDS_DB_NAME foo
ENV RDS_PASSWORD foo
ENV RDS_USERNAME foo
ENV RDS_PORT foo

ADD docker/images/php/container-files/config /config
ADD docker/images/php/container-files/etc/nginx /etc/nginx
ADD docker/images/php/container-files/etc/php-fpm.d /etc/php-fpm.d
ADD docker/images/php/container-files/etc/supervisor.d /etc/supervisor.d
ADD docker/images/php/container-files/etc/php.d /etc/php.d
ADD docker/images/php/container-files/etc/php-fpm.conf /etc/php-fpm.conf
ADD docker/images/php/container-files/install-wp.sh /install-wp.sh

## NODE
RUN \
    yum install -y ruby ruby-devel nodejs npm zlib-devel libpng-devel && \
    yum clean all

## GRUNT
RUN npm install -g grunt-cli

### COMPOSER
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/bin/composer

## MYSQL command
RUN yum install mysql -y

EXPOSE 80 443