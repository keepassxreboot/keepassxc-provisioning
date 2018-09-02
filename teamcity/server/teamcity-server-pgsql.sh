#!/usr/bin/env bash

docker stop teamcity-server-pgsql 2> /dev/null
docker wait teamcity-server-pgsql > /dev/null 2>&1
docker rm teamcity-server-pgsql 2> /dev/null

docker run -d --restart on-failure:5 --name teamcity-server-pgsql   \
    -v /home/teamcity/server-pgsql/data:/var/lib/postgresql/data  \
    -v /home/teamcity/server-pgsql/password:/etc/server-password \
    -p 172.17.0.1:5432:5432 \
    -e POSTGRES_USER=teamcity \
    -e POSTGRES_PASSWORD_FILE=/etc/server-password \
    -e POSTGRES_DB=teamcity \
    postgres

