#!/bin/sh

set -e

# if /config doesnt exist, exit
test -d /config || exit 1

mkdir -p /config/cache

touch /config/config.ini
touch /config/sickbeard.db
touch /config/sickbeard.db.v43

cd /sickrage

# get latest git data
git pull origin

# start sickrage
/usr/bin/python /sickrage/SickBeard.py --datadir=/config/ --config=/config/config.ini
