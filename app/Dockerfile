FROM mattermost/mattermost-prod-app

# Build argument to set Mattermost edition
ARG edition=team
ARG PUID=1000
ARG PGID=1000

USER root 

RUN mkdir -p /srv

# add mariadb-client
RUN set -x ; \
    env ; id ; touch /etc/toto ; ls -al /etc/toto ; \
    [[ ! -z "$PROXY" ]] && export http_proxy=${PROXY} && https_proxy=${PROXY} ; \
    apk update ; \
    apk add mariadb-client shadow \
	&& rm -rf /tmp/*

RUN set -x ; \
  usermod -u ${PUID} mattermost ; \
  usermod -g ${PGID} mattermost ; \
  chown -R mattermost:mattermost /mattermost

USER mattermost 

RUN set -x ; id

COPY entrypoint-override.sh /
ADD override /app/override

ENTRYPOINT ["/entrypoint-override.sh"]
WORKDIR /mattermost
CMD ["mattermost"]

VOLUME ["/mattermost/data", "/mattermost/logs", "/mattermost/config", "/srv"]

