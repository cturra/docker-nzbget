FROM alpine:latest

# grab/install everything required for nzbget.
RUN apk update   \
 && apk add wget \
 && rm -rf /var/cache/apk/*

# copy startup script
COPY assets/startup.sh /opt/startup.sh

# kick off supervisord+nzbget
ENTRYPOINT [ "/bin/sh", "/opt/startup.sh" ]
