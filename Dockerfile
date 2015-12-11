FROM ubuntu:14.04

MAINTAINER chris turra <cturra@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV VERSION         16.4

# grab/install everything required to compile and launch nzbget.
RUN apt-get -qq update && \
    apt-get -y install software-properties-common && \
    add-apt-repository "deb http://archive.ubuntu.com/ubuntu/ trusty-security multiverse" && \
    apt-get -qq update && \
    apt-get -yf install build-essential \
                        libncurses5-dev \
                        libssl-dev \
                        libxml2-dev \
                        supervisor \
                        unrar \
                        wget && \
    rm -rf /var/lib/apt/lists/*

COPY conf/supervisord.conf /etc/supervisor/conf.d/nzbget.conf
COPY conf/prerun.sh        /root/nzbget-prerun.sh

WORKDIR /tmp

# download/install/config nzbget
RUN wget -O /tmp/nzbget.tar.gz \
         -q https://github.com/nzbget/nzbget/releases/download/v${VERSION}/nzbget-${VERSION}-src.tar.gz && \
    tar -xf nzbget.tar.gz && \
    rm -f nzbget.tar.gz && \
    cd nzbget-${VERSION} && \
    sh configure --with-tlslib=OpenSSL \
                 --with-libxml2-includes=/usr/include/libxml2 \
                 --with-libxml2-libraries=/usr/lib/x86_64-linux-gnu/libxml2.so && \
    make && \
    make install && \
    rm -rf /tmp/nzbget-${VERSION} && \
    chmod +x /root/nzbget-prerun.sh

EXPOSE 6789/tcp

# kick off supervisord+nzbget
CMD ["/usr/bin/supervisord"]
