FROM alpine:edge
MAINTAINER scorputty
LABEL Description="Sickrage" Vendor="Stef Corputty" Version="0.0.8"

# variables
ENV TZ="Europe/Amsterdam"
ENV appUser="media"
ENV appGroup="media"
ENV PUID="10000"
ENV PGID="10000"

# ports should be mapped with the run command to match your situation
EXPOSE 8081

# copy the start script and config to the container
COPY start.sh /start.sh

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
       pyopenssl cryptography cheetah mako lockfile ndg-httpsclient notify pyasn1 requirements && \

# get sickrage and update is now in start.sh
 git clone --depth 1 https://github.com/SickRage/SickRage.git /sickrage && \

# cleanup
 cd / && \
 apk del --purge \
       build-dependencies && \
 rm -rf \
       /var/cache/apk/* \
       /tmp/*

# user with access to media files and config
RUN addgroup -g ${PGID} ${appGroup} && \
 adduser -G ${appGroup} -D -u ${PUID} ${appUser}

# create dir to be mounted over by volume
RUN mkdir -p /share/config/sickrage && touch /share/config/sickrage/tag.txt

# set owner
RUN chown -R ${appUser}:${appGroup} /start.sh /sickrage /share

# make sure start.sh is executable
RUN chmod u+x  /start.sh

# switch to App user
USER ${appUser}

# single mounted shared volume
VOLUME ["/share"]

# start application
CMD ["/start.sh"]
