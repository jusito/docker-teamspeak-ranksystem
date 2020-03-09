FROM php:7.4.3-apache

EXPOSE 80/tcp

#/usr/local/etc/php/php.ini not existing default
#http://pecl.php.net/package/ssh2

RUN cd /tmp && \
        curl -L https://github.com/Newcomer1989/TSN-Ranksystem/tarball/master > archive && \
        tar -xf 'archive' && \
        cd */ && \
        mkdir -p '/var/www/html/ranksystem' && \
        mv * '/var/www/html/ranksystem' && \
        chown -R 'www-data:www-data' '/var/www/html/ranksystem' && \
        cd .. && \
        rm -rf */ && \
        \
        chmod -R ugo=rwx '/var/www/html/ranksystem/'

#chmod -R ugo=rwx '/var/www/html/ranksystem/update' && \
#chmod -R ugo=rwx '/var/www/html/ranksystem/logs' && \
#chmod -R ugo=rwx '/var/www/html/ranksystem/tsicons' && \
#chmod -R ugo=rwx '/var/www/html/ranksystem/avatars'

RUN apt-get update -y && \
        apt-get install -y libcurl3-dev libzip-dev libssh2-1-dev libonig-dev && \
        \
        pecl install ssh2-1.2 && \
        \
        docker-php-ext-install curl && \
        docker-php-ext-install zip && \
        docker-php-ext-install pdo && \
        docker-php-ext-install pdo_mysql && \
        docker-php-ext-install mbstring && \
        \
        docker-php-ext-enable curl && \
        docker-php-ext-enable zip && \
        docker-php-ext-enable pdo && \
        docker-php-ext-enable pdo_mysql && \
        docker-php-ext-enable ssh2 && \
        docker-php-ext-enable mbstring
