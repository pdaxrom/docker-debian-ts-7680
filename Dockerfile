FROM scratch
ADD ftp://ftp.embeddedarm.com/ts-arm-sbc/ts-7680-linux/distributions/ts7680-linux4.9-debian-stretch-arm-20190220.tar.bz2 /

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive

COPY qemu-arm-static /usr/bin/

RUN apt-get update
RUN apt-get install -y mc build-essential ccache pkg-config m4 perl python rpm
RUN apt-get clean

WORKDIR /root

# make /bin/sh symlink to bash instead of dash:
RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

RUN echo "export QEMU_CPU=arm926" >> /etc/profile

CMD ["/bin/bash", "-l"]
