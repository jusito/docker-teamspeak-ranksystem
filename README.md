# docker-teamspeak-ranksystem
WIP image for https://ts-n.net/ranksystem.php

# important

A note to all who want to use this repo:
I am a beginner. Most of what i wrote happened by "trial and error". Please be aware of that.

# run a new database

Just download a mariadb image from dockerhub and start it with the following command:

```docker run -d --name "RanksystemDatabase" --network="bridge" --hostname ranksystemdb.docker.local -v /my/own/datadir:/var/lib/mysql -e MYSQL_ROOT_PASSWORD="my-secret-pw" mariadb:latest``` 

We used a hostname here: That way you can enter "ranksystemdb.docker.local" as the ip in the ranksystem.

The ``` -v /my/own/datadir:/var/lib/mysql```  part of the command mounts the ```/my/own/datadir``` directory from the underlying host system as /var/lib/mysql inside the container, where MySQL by default will write its data files.

To start the docker container that you've created with my dockerfile:

``` docker run -d --network="bridge" --name "Teamspeak_Ranksystem" kourgiantakis/docker-teamspeak-ranksystem:latest``` 

Add ```-p 8765:80```  to change the Port from 80 to 8765 or whatever you like.

# webroot
I changed apaches webroot to /ranksystem.

# link on dockerhub

If you'd like to download the image:

https://hub.docker.com/r/kourgiantakis/docker-teamspeak-ranksystem

# how to get the ip of mariadb?
docker inspect "RanksystemDatabase" or just use "ranksystemdb.docker.local"

# docker-compose

I created a docker-compose that fits my personal needs.
It creates the following combination of containers:

- Teamspeak3
- Sinusbot
- Database (for the Ranksystem)
- Ranksystem

It puts them all into the same network and assigns hostnames.
The volume for the persistance is always in /srv/
The only exception is the dboconfig of the ranksystem.
