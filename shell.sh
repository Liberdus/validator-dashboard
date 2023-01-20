#!/usr/bin/env bash

if ! command -v docker >/dev/null 2>&1 ; then
    echo >&2 "docker command not found. Aborting."
    exit 1
fi

if ! docker ps >/dev/null 2>&1 ; then
    echo "docker command requires sudo, creating function"
    alias docker='sudo docker'
else
    echo "docker command works without sudo"
fi

docker exec -it shardeum-dashboard /bin/bash