FROM ubuntu:24.10

ENV MBS_MAILBOX_NAME default
ENV MBS_DATA /var/lib/mbsync
ENV MBS_TLSTYPE IMAPS

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    cron \
    isync \
    openssl \
    && rm -rf /var/lib/apt/lists/*

COPY mbsyncrc /etc/mbsync/mbsyncrc

COPY docker-entrypoint.sh run-mbsync.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh /usr/local/bin/run-mbsync.sh
ENTRYPOINT [ "docker-entrypoint.sh" ]
