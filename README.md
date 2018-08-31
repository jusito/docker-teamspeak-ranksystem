# docker-teamspeak-ranksystem
WIP image for https://ts-n.net/ranksystem.php

# run a new database
docker run -d --network="bridge" --name "RanksystemDatabase" -v RanksystemDatabase:/var/lib/mysql -e MYSQL_ROOT_PASSWORD="MySecurePassword" mariadb:10.3

docker run -d --network="bridge" --name "Teamspeak_Ranksystem" jusito/docker-teamspeak-ranksystem:develop

# how to get the ip of mariadb?
docker inspect "RanksystemDatabase"