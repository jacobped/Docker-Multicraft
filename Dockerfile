FROM openjdk:8-jre

LABEL maintainer="me@lzstealth.com" \
	  description="Dockerised Multicraft panel"

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
	lib32gcc1 lib32stdc++6 wget binutils apache2 \
	php7.0 php7.0-cli libapache2-mod-php7.0 sqlite3 php7.0-sqlite php7.0-mysql php7.0-gd \
	vim zip unzip imagemagick lsof && apt-get clean && \
	a2enmod php7.0

VOLUME /mc

COPY * /

RUN chmod +x /init.sh

ENV MC_DAEMON_ID="1" \
    MC_DAEMON_PW="ChangeMe" \
    MC_FTP_IP="" \
    MC_FTP_PORT="21" \
    MC_FTP_SERVER="y" \
    MC_KEY=""

CMD ["/init.sh"]
