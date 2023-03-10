FROM linuxserver/mariadb
LABEL description="Script to backup all databases of a mariadb instance." \
      maintainer="Jérôme Gillard"

ENV BACKUP_DB_HOST=mariadb
ENV BACKUP_DB_USER=root
ENV BACKUP_DB_PASSWORD=root
ENV BACKUP_NUM_KEEP=7
ENV BACKUP_FREQUENCY=1d
ENV BACKUP_UID=1001
ENV BACKUP_GID=1001



COPY entrypoint.sh .

RUN mkdir /dump && \
    chmod +x entrypoint.sh && \
    chown ${BACKUP_UID}:${BACKUP_GID} /dump

VOLUME [ "/dump" ]
ENTRYPOINT [ "/bin/bash", "-c", "/entrypoint.sh" ]

# docker buildx create --name mybuilder --use --bootstrap
# docker buildx build --push --platform linux/amd64,linux/arm64,linux/arm/v7 --tag jeromegillard/mariadb-backup:latest .