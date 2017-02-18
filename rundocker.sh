#!/usr/bin/env bash

# edit for your situation (config/sickrage should be there)
VOL_SHARE="/Volumes/shares/docker/"

test -d ${VOL_SHARE} || VOL_SHARE="${PWD}${VOL_SHARE}" && mkdir -p ${VOL_SHARE}/config/sickrage

docker run -d -h $(hostname) \
    -p 8081:8081 \
    -v ${VOL_SHARE}:/share \
    -e TZ="Europe/Amsterdam" \
    -e appUser="media" \
    -e appGroup="media" \
    -e PUID="10000" \
    -e PGID="10000" \
    --name=sickrage --restart=always cryptout/sickrage

  # for troubleshooting run
  # docker exec -it sickrage /bin/bash
  # to check logs run
  # docker logs -f sickrage
