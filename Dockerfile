FROM ubuntu:16.04

MAINTAINER chris turra <cturra@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# grab/install everything required for nzbget.
RUN echo "deb http://us.archive.ubuntu.com/ubuntu xenial main multiverse" >> /etc/apt/sources.list \
 && apt-get -q update             \
 && apt-get -y install p7zip-full \     
                       unrar      \
                       wget       \
 && rm -rf /var/lib/apt/lists/*

# copy startup script
COPY assets/startup.sh /opt/startup.sh

# kick off supervisord+nzbget
ENTRYPOINT [ "/bin/bash", "/opt/startup.sh" ]
