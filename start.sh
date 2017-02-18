#!/bin/sh

set -e

# /share/config maps to nfs share home-server/config
test -d /share/config/sickrage || exit 1

# make user to update config.ini to match this cache location
mkdir -p /tmp/cache

touch /share/config/sickrage/config.ini
touch /share/config/sickrage/sickbeard.db
touch /share/config/sickrage/sickbeard.db.v43

cd /sickrage

# get latest git data
git pull origin

# start sickrage
/usr/bin/python /sickrage/SickBeard.py --datadir=/share/config/sickrage --config=/share/config/sickrage/config.ini
