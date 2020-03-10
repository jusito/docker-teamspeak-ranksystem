# docker-teamspeak-ranksystem
WIP image for https://ts-n.net/ranksystem.php

# updates of this fork

In comparison to the original repo, I have only modified a few minor things.
I changed the link to the TSN Rank System in the Dockerfile so that it will always point to the latest version.

I also updated to the latest php version and updated some modules.

I also updated the permissions because they were too broad and imprecise.

A note to all who want to use this repo:
I am a Linux and Docker beginner. Most of what i changed happened by "trial and error". Please be aware of that.

# run a new database

Just download a mariadb image from dockerhub and start it with the following command:

docker run -d --network="bridge" --name "RanksystemDatabase" -v RanksystemDatabase:/var/lib/mysql -e MYSQL_ROOT_PASSWORD="MySecurePassword" mariadb:latest

To start the docker container that you've created with my dockerfile:

docker run -d --network="bridge" --name "Teamspeak_Ranksystem" tsn-docker:latest

Add -p 8765:80 to change the Port from 80 to 8765 since port 80 is in use on most servers.

# link on dockerhub

If you'd like to download the image:

https://hub.docker.com/r/kourgiantakis/docker-teamspeak-ranksystem

# how to get the ip of mariadb?
docker inspect "RanksystemDatabase"
