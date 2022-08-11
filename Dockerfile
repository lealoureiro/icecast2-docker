FROM ubuntu:22.04 as builder

# Image info
LABEL maintainer="Leandro Loureiro <leandroloureiro@proton.me>" 
LABEL github="https://github.com/lealoureiro/icecast2-docker"

# Basic build tools
RUN apt-get update && apt-get upgrade -y
RUN apt-get install apt-utils -y
RUN DEBIAN_FRONTEND=noninteractive TZ=Europe/Amsterdam apt-get install git \
    autoconf pkg-config libtool build-essential libxml2-dev libxslt1-dev libvorbis-dev -y

# Building Icecast2
WORKDIR /root
RUN git clone --recursive -b v2.4.3 https://gitlab.xiph.org/xiph/icecast-server.git
WORKDIR /root/icecast-server
RUN ./autogen.sh
RUN ./configure
RUN make

# Preparing distribution image
FROM ubuntu:22.04

RUN apt-get update && apt-get upgrade -y
RUN apt-get install libvorbis0a libxslt1.1 -y

RUN mkdir /app
WORKDIR /app
RUN mkdir bin && mkdir content

COPY --from=builder /root/icecast-server/src/icecast bin/
COPY --from=builder /root/icecast-server/web content/web
COPY --from=builder /root/icecast-server/admin content/admin

VOLUME ["/app/conf", "/app/log/"]

EXPOSE 8000

CMD /app/bin/icecast -c /app/conf/icecast2.xml