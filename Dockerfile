FROM php:5.6.37-apache
#7.2.9 tested, not working
EXPOSE 80/tcp


#needed: PDO, php, cURL, Zip, SSH2
#SSH2 needed to compile, see comentary: http://php.net/manual/de/ssh2.installation.php
RUN cd /tmp && \
	curl -L -o 'archive' 'https://github.com/Newcomer1989/TSN-Ranksystem/archive/1.2.10.tar.gz' && \
	tar -xf 'archive' && \
	cd * && \
	mkdir -p '/var/www/html/ranksystem' && \
	mv * '/var/www/html/ranksystem' && \
	chown -R 'www-data:www-data' '/var/www/html/ranksystem' && \
	cd .. && \
	rm -rf * && \
	\
	chmod -R ugo=rwx '/var/www/html/ranksystem/'
	
#chmod -R ugo=rwx '/var/www/html/ranksystem/update' && \
#chmod -R ugo=rwx '/var/www/html/ranksystem/logs' && \
#chmod -R ugo=rwx '/var/www/html/ranksystem/tsicons' && \
#chmod -R ugo=rwx '/var/www/html/ranksystem/avatars'
	
#libcurl3 libcurl3-dev
RUN apt-get update -y && \
	apt-get install -y zlib1g-dev libcurl3-dev && \
	\
	docker-php-ext-install curl && \
	docker-php-ext-install zip && \
	docker-php-ext-install pdo && \
	docker-php-ext-install pdo_mysql && \
	\
	docker-php-ext-enable curl && \
	docker-php-ext-enable zip && \
	docker-php-ext-enable pdo && \
	docker-php-ext-enable pdo_mysql