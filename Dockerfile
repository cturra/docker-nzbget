FROM ubuntu:16.04

MAINTAINER chris turra <cturra@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV TERM            vt100
ENV VERSION         16.4

# grab/install everything required to compile and launch nzbget.
RUN echo "deb http://us.archive.ubuntu.com/ubuntu xenial main multiverse" >> /etc/apt/sources.list \
 && apt-get -q update                  \
 && apt-get -y install build-essential \
                       libncurses5-dev \
                       libssl-dev      \
                       libxml2-dev     \
                       unrar           \
                       wget            \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

# download/install/config nzbget
RUN wget -O /tmp/nzbget.tar.gz                                                                          \
         -q https://github.com/nzbget/nzbget/releases/download/v${VERSION}/nzbget-${VERSION}-src.tar.gz \
 && tar -xf nzbget.tar.gz \
 && rm -f nzbget.tar.gz   \
 && cd nzbget-${VERSION}  \
 && sh configure --with-tlslib=OpenSSL                                         \
                 --with-libxml2-includes=/usr/include/libxml2                  \
                 --with-libxml2-libraries=/usr/lib/x86_64-linux-gnu/libxml2.so \
 && make                                                                       \
 && make install                                                               \
 && rm -rf /tmp/nzbget-${VERSION}

# copy startup script
COPY assets/startup.sh /opt/startup.sh

# kick off supervisord+nzbget
ENTRYPOINT [ "/bin/bash", "/opt/startup.sh" ]
