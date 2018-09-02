#!/usr/bin/env bash

docker stop teamcity-server 2> /dev/null
docker wait teamcity-server > /dev/null 2>&1
docker rm teamcity-server 2> /dev/null

docker run -d --restart on-failure:5 --name teamcity-server   \
    -v /home/teamcity/server:/data/teamcity_server/datadir  \
    -v /var/log/teamcity:/opt/teamcity/logs   \
    -p 8111:8111 \
    --mount type=tmpfs,destination=/opt/teamcity/work \
    --mount type=tmpfs,destination=/opt/teamcity/temp \
    jetbrains/teamcity-server

