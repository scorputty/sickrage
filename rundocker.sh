#!/usr/bin/env bash

# edit for your situation
VOL_DATA="/Volumes/shares/docker/data/sickrage/data"
VOL_CONFIG="/Volumes/shares/docker/data/sickrage/config"
VOL_MEDIA="/Volumes/shares/docker/media"

test -d ${VOL_DATA} || VOL_DATA="${PWD}${VOL_DATA}" && mkdir -p ${VOL_DATA}
test -d ${VOL_CONFIG} || VOL_CONFIG="${PWD}${VOL_CONFIG}" && mkdir -p ${VOL_CONFIG}
test -d ${VOL_MEDIA} || VOL_MEDIA="${PWD}${VOL_MEDIA}" && mkdir -p ${VOL_MEDIA}

docker run -d -h $(hostname) \
    -p 8081:8081 \
    -v ${VOL_DATA}:/data \
    -v ${VOL_CONFIG}:/config \
    -v ${VOL_MEDIA}:/media \
    -v /etc/localtime:/etc/timezone:ro \
    -e TZ="Europe/Amsterdam" \
    -e appUser="media" \
    -e appGroup="media" \
    -e USER="10000:10000" \
    --name=sickrage --restart=always cryptout/sickrage

  # for troubleshooting run
  # docker exec -it sickrage /bin/bash
  # to check logs run
  # docker logs -f sickrage
