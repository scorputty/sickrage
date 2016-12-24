[![Build Status](https://travis-ci.org/scorputty/sickrage.svg?branch=master)](https://travis-ci.org/scorputty/sickrage) [![](https://images.microbadger.com/badges/image/cryptout/sickrage.svg)](https://microbadger.com/images/cryptout/sickrage "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/cryptout/sickrage.svg)](https://microbadger.com/images/cryptout/sickrage "Get your own version badge on microbadger.com")

# Docker sickrage (Alpine)

This is a Dockerfile to set up "sickrage" - (https://sickragebt.com/).

### Docker Hub
The built image is also hosted at Docker Hub - (https://hub.docker.com/r/cryptout/sickrage/).
If you don't want to customize the container you can run it directly by typing the following commands.
```sh
export VOL_DATA="/Volumes/shares/docker/data/sickrage/data"
export VOL_CONFIG="/Volumes/shares/docker/data/sickrage/config"
export VOL_CACHE="/Volumes/shares/docker/cache/sickrage/cache"

docker run -d -h $(hostname) \
    -p 8081:8081 \
    -v ${VOL_DATA}:/data \
    -v ${VOL_CONFIG}:/config \
    -v ${VOL_CACHE}:/cache \
    -v /etc/localtime:/etc/timezone \
    -e PUID=1000 \
    -e PGID=1000 \
    --name=sickrage --restart=always cryptout/sickrage
```

# Build from Dockerfile
Clone this repository and run the build.sh script.
```sh
git clone https://github.com/scorputty/sickrage.git
cd sickrage
./build.sh
```

### Variables
Change to match your situation.
```Dockerfile
ENV appUser="media"
ENV appGroup="1000"
```

### Volumes
Make sure to map the Volumes to match your situation.
```Dockerfile
VOLUME ["/data"]
VOLUME ["/config"]
VOLUME ["/cache"]
```

### To run the container
Edit rundocker.sh (this will be replaced by docker-compose soon...).
```sh
./rundocker.sh
```

### WebGUI
To reach the WebGUI go to - (http://localhost:9091).
Or replace localhost with your target IP. Login with admin/sickrage.

## Info
* Shell access whilst the container is running: `docker exec -it sickrage /bin/sh`
* To monitor the logs of the container in realtime: `docker logs -f sickrage`
* Change sickrage-daemon config: `docker run -ti cryptout/sickrage vi /etc/sickrage-daemon/settings.json`

# Notes
I'm still learning Docker and use these private (pet)projects to develop my skills.
While I use these containers myself they are by no means perfect and are always prone to error or change.
That said, even if only one person copies a snippet of code or learns something from my projects I feel I've contributed a little bit to the Open-source cause...
