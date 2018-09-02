#!/usr/bin/env bash

mkdir -p /dev/shm/teamcity-agent-work
chmod 700 /dev/shm/teamcity-agent-work

docker stop teamcity-agent 2> /dev/null
docker wait teamcity-agent > /dev/null 2>&1
docker rm teamcity-agent 2> /dev/null

docker run -d --privileged --restart on-failure --name teamcity-agent \
    -e SERVER_URL=http://betaweb131:8111 \
    -e AGENT_NAME=worker_01 \
    -e DOCKER_IN_DOCKER=start \
    -v docker_volumes:/var/lib/docker \
    -v /home/teamcity/agent/conf:/data/teamcity_agent/conf \
    -v /var/log/teamcity-agent:/opt/buildagent/logs \
    -v /dev/shm/teamcity-agent-work:/opt/buildagent/work \
    --tmpfs /opt/buildagent/temp:rw,nosuid,exec \
    jetbrains/teamcity-agent

