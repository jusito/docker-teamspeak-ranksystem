# docker-teamspeak-ranksystem
WIP (currently more a template) Image for https://ts-n.net/ranksystem.php

# usage
## Start a teamspeak 3 server
```
docker run -d --name "Teamspeak" \
 -p 9987:9987/udp -p 30033:30033 -p 30000:10011 -p 10022:10022 \
 -e TS3SERVER_LICENSE=accept \
 --network="bridge" \
 --volume="Teamspeak:/var/ts3server/:rw" \
 --restart=unless-stopped \
 "teamspeak:latest"
```

## Prepare a mysql container
1. Choose mysql container name `--name "Teamspeak_Ranksystem_Database"`
2. Choose a secure root password `-e MYSQL_ROOT_PASSWORD="MySecurePassword"`
3. Choose hostname under which the database is locally accessible `--hostname "ranksystemdb.docker.local"`
4. Fill in your selected details and run the following to start a database.

```
docker run -d \
 --name "Teamspeak_Ranksystem_Database" \
 -e MYSQL_ROOT_PASSWORD="MySecurePassword" \
 --network="bridge" \
 -v RanksystemDatabase:/var/lib/mysql \
 --restart=unless-stopped \
 mariadb:10.5.7
```

## Start the ranksystem bot

1. Choose ranksystem container name `--name Teamspeak_Ranksystem`
2. Choose the port `-p 8080:80`
3. Do you want to use the tested version? If not choose the version `-e RANKSYSTEM_VERSION=1.3.12`, branch/tag name allowed (`-e RANKSYSTEM_VERSION=master`)
4. Fill in your selected details and run the following to start the ranksystem bot.

```
docker run -d \
 --name "Teamspeak_Ranksystem" \
 -p 8080:80  \
 --network="bridge" \
 --restart=unless-stopped \
 -v Teamspeak_Ranksystem \
 jusito/docker-teamspeak-ranksystem
```

## follow ranksystem installation

1. What is the domain or ip of your server? `http://example.com`
2. Port you select? `8080`
3. Fill in your selected details and open url: `http://example.com:8080/install.php`
4. Get database ip: `docker inspect -f "{{.NetworkSettings.IPAddress}}" Teamspeak_Ranksystem_Database`
5. If you followed all from above choose `mysql`, with host address from `4.`, DB name `ts3_ranksystem`, DB user `root` and DB password `MySecurePassword`
6. Hit install database and follow instructions like creating webinterface user. After this dont miss to connect your ts server `http://example.com:8080/webinterface/ts.php`

# ToDo - feel free to contribute
## Documentation
- How to use with reverse proxy & https (Traefik or jwilder/nginx-proxy with companion) + ts dns + ... (ranksystem.ts.mydomain.de -> reverse proxy -> container)
- Examples with compose.yml
- PHP logs? config? + apache?
- Description of logs / config files
- Healthcheck, reachable + connection to ts3 working + x, any status information of ranksystem?
- permissions ?
- Debug mode over env for apache / php / ranksystem / scripts / ...