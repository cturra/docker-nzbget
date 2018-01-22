FROM alpine:latest

# grab/install everything required for nzbget.
RUN apk add --no-cache p7zip \
                       unrar \
                       wget

# copy startup script
COPY assets/startup.sh /opt/startup.sh

# kick off supervisord+nzbget
ENTRYPOINT [ "/bin/sh", "/opt/startup.sh" ]
