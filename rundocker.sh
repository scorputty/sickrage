#!/usr/bin/env bash

# edit for your situation
VOL_DATA="/Volumes/shares/docker/data/sickrage/data"
VOL_CONFIG="/Volumes/shares/docker/data/sickrage/config"
VOL_CACHE="/Volumes/shares/docker/cache/sickrage/cache"

test -d ${VOL_DATA} || VOL_DATA="${PWD}${VOL_DATA}" && mkdir -p ${VOL_DATA}
test -d ${VOL_CONFIG} || VOL_CONFIG="${PWD}${VOL_CONFIG}" && mkdir -p ${VOL_CONFIG}
test -d ${VOL_CACHE} || VOL_CACHE="${PWD}${VOL_CACHE}" && mkdir -p ${VOL_CACHE}

docker run -d -h $(hostname) \
    -p 8081:8081 \
    -v ${VOL_DATA}:/data \
    -v ${VOL_CONFIG}:/config \
    -v ${VOL_CACHE}:/cache \
    -v /etc/localtime:/etc/timezone \
    -e PUID=1000 \
    -e PGID=1000 \
    --name=sickrage --restart=always cryptout/sickrage

  # for troubleshooting run
  # docker exec -it sickrage /bin/bash
  # to check logs run
  # docker logs -f sickrage
