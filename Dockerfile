FROM alpine:edge

MAINTAINER scorputty
LABEL Description="Sickrage" Vendor="Stef Corputty" Version="0.0.5"

# variables
ENV TZ="Europe/Amsterdam"
ENV appUser="media"
ENV appGroup="media"
ENV PUID="10000"
ENV PGID="10000"

# mounted volumes should be mapped to media files and config with the run command
VOLUME ["/config", "/media"]

# ports should be mapped with the run command to match your situation
EXPOSE 8081

# copy the start script and config to the container
COPY ./start.sh /start.sh

# install runtime packages
RUN \
 apk --update add --no-cache \
       ca-certificates \
       bash \
       su-exec \
       py2-pip \
       git \
       python \
       py-libxml2 \
       py-lxml \
       openssl-dev \
       libffi-dev \
       unrar \
       tzdata && \

# update certificates
       update-ca-certificates && \

# install build packages (these will be removed later)
       apk add --no-cache --virtual=build-dependencies \
       g++ \
       gcc \
       make \
       python-dev && \

# install pip packages
 pip install --upgrade pip && \
 pip install --no-cache-dir -U \
       setuptools && \
 pip install --no-cache-dir -U \
       pyopenssl cheetah requirements && \

# get sickrage and update
 git clone --depth 1 https://github.com/SickRage/SickRage.git /sickrage && \
 cd sickrage && \
 git remote set-url origin https://github.com/SickRage/SickRage.git && \
 git fetch origin && \
 git checkout master && \
 git branch -u origin/master && \
 git reset --hard origin/master && \
 git pull && \

# cleanup
 cd / && \
 apk del --purge \
       build-dependencies && \
 rm -rf \
       /var/cache/apk/* \
       /sickrage/.git \
       /tmp/*

# create directories
RUN mkdir -p /config && \
 mkdir -p /media


# user with access to media files and config
RUN addgroup -g ${PGID} ${appGroup} && \
 adduser -G ${appGroup} -D -u ${PUID} ${appUser}

# set owner
RUN chown -R ${appUser}:${appGroup} /start.sh /config /media /sickrage

# switch to App user
USER ${appUser}

# start application
CMD ["/start.sh"]
