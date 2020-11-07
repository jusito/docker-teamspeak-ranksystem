FROM php:7.4.12-apache

COPY "entrypoint.sh" "/usr/local/bin/"

RUN apt-get update -y && \
        apt-get install -y busybox libcurl3-dev libzip-dev libssh2-1-dev libonig-dev && \
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
        docker-php-ext-enable mbstring && \
        \
        mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" && \
        \
        chmod -R ugo=rx /usr/local/bin/entrypoint.sh

ENTRYPOINT "entrypoint.sh"

EXPOSE 80/tcp

ENV RANKSYSTEM_VERSION=1.3.12 \
	VOLUME="/var/www/html"

VOLUME [ "/var/www/html" ]
