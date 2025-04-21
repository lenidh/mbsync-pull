FROM ubuntu:25.04

ENV MBS_MAILBOX_NAME default
ENV MBS_DATA /var/lib/mbsync
ENV MBS_TLSTYPE IMAPS
ENV MBS_UID 1000
ENV MBS_GID 1000

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    cron \
    isync \
    openssl \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

COPY mbsyncrc /etc/mbsync/mbsyncrc

COPY docker-entrypoint.sh run-mbsync.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh /usr/local/bin/run-mbsync.sh
ENTRYPOINT [ "docker-entrypoint.sh" ]
