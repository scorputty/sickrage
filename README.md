[![Build Status](https://travis-ci.org/scorputty/sickrage.svg?branch=master)](https://travis-ci.org/scorputty/sickrage) [![](https://images.microbadger.com/badges/image/cryptout/sickrage.svg)](https://microbadger.com/images/cryptout/sickrage "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/cryptout/sickrage.svg)](https://microbadger.com/images/cryptout/sickrage "Get your own version badge on microbadger.com")

# Docker Sickrage (python:2)

This is a Dockerfile to build "Sickrage" - (https://sickragebt.com/).

### Docker Hub
The built image is also hosted at Docker Hub - (https://hub.docker.com/r/cryptout/sickrage/).

# Build from Dockerfile
Clone this repository and run the build.sh script.
```sh
git clone https://github.com/scorputty/sickrage.git
cd sickrage
./build.sh
```

# Docker compose example
```
sickrage:
  container_name: sickrage
  image: docker.io/cryptout/sickrage
  hostname: sickrage
  network_mode: host
  environment:
    - TZ=Europe/Amsterdam
    - USER=media
    - USERID=10000
    - PUID=10000
    - PGID=10000
    - ENV appUser=media
    - ENV appGroup=media
  volumes:
    - /share:/share
```

### WebGUI
To reach the WebGUI go to - (http://localhost:9091).
Or replace localhost with your target IP. Login with admin/sickrage.

## Info
* Shell access whilst the container is running: `docker exec -it sickrage /bin/sh`
* To monitor the logs of the container in realtime: `docker logs -f sickrage`


# Notes
I'm still learning Docker and use these private (pet)projects to develop my skills.
While I use these containers myself they are by no means perfect and are always prone to error or change.
That said, even if only one person copies a snippet of code or learns something from my projects I feel I've contributed a little bit to the Open-source cause...
