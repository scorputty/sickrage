FROM python:3.10
MAINTAINER scorputty
LABEL Description="Sickrage" Vendor="Stef Corputty" Version="0.7"

# variables
ENV TZ="Europe/Amsterdam"
ENV appUser="media"
ENV appGroup="media"
ENV PUID="10000"
ENV PGID="10000"

# ports should be mapped with the run command to match your situation
EXPOSE 8081

# get sickrage
RUN git clone --depth 1 https://github.com/SickRage/SickRage.git /opt/sickrage/

# install app
RUN pip install -U pip setuptools
RUN pip install -r /opt/sickrage/requirements.txt


# user with access to media files and config
RUN groupadd -g ${PGID} ${appGroup} && \
 useradd -g ${appGroup} -u ${PUID} ${appUser}

# create dir to be mounted over by volume
RUN mkdir -p /share/config/sickrage && touch /share/config/sickrage/tag.txt

# set owner
RUN chown -R ${appUser}:${appGroup} /opt/sickrage /share

# switch to App user
USER ${appUser}

# single mounted shared volume
VOLUME ["/share"]

# start application
ENTRYPOINT python /opt/sickrage/SiCKRAGE.py --nolaunch --datadir=/share/config/sickrage --config=/share/config/sickrage/config.ini
