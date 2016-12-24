FROM alpine:edge

MAINTAINER scorputty
LABEL Description="Sickrage" Vendor="Stef Corputty" Version="0.0.1"

# variables
ENV appUser="media"
ENV appGroup="1000"

# mounted volumes should be mapped to media files and config with the run command
VOLUME ["/config", "/data", "/cache"]

# ports should be mapped with the run command to match your situation
EXPOSE 8081

# copy the start script and config to the container
COPY ./start.sh /start.sh

# install runtime packages
RUN \
 apk --update add --no-cache \
       ca-certificates \
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
 pip install --no-cache-dir -U \
       setuptools && \
 pip install install --no-cache-dir -U \
       pyopenssl cheetah requirements && \

# get sickrage
 git clone --depth 1 https://github.com/SickRage/SickRage.git /sickrage && \

# cleanup
 cd / && \
 apk del --purge \
       build-dependencies && \
 rm -rf \
       /var/cache/apk/* \
       /sickrage/.git \
       /tmp/*

# create directories
RUN mkdir -p /config \
  && mkdir -p /data \
  && mkdir -p /cache

# user with access to media files and config
RUN adduser -D -u ${appGroup} ${appUser}

# set owner
RUN chown -R ${appUser}:${appGroup} /start.sh /config /data /cache

# switch to App user
USER ${appUser}

# start application
CMD ["/start.sh"]
