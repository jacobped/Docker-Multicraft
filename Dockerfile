FROM openjdk:8-jre-slim

LABEL description="Dockerised Multicraft panel and daemon"
ENV DEBIAN_FRONTEND=noninteractive \
    LC_ALL=C.UTF-8 \
    PHP_VERSION=7.4 \
    CONFIG_DIR=/config

ENV EXTRA_PACKAGES="mlocate" \
    PHP_PACKAGES="php${PHP_VERSION} php${PHP_VERSION}-cli libapache2-mod-php${PHP_VERSION} sqlite3 php${PHP_VERSION}-sqlite php${PHP_VERSION}-mysql php${PHP_VERSION}-gd php${PHP_VERSION}-pdo" \
    BUILD_PACKAGES="wget"

RUN apt-get update && \
    apt-get install -y $BUILD_PACKAGES gnupg2 software-properties-common && \
    wget -qO - https://packages.sury.org/php/apt.gpg | APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 apt-key add - && \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php7.list && \
    apt-get remove -y $BUILD_PACKAGES software-properties-common && \
    apt autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y --no-install-recommends $EXTRA_PACKAGES $PHP_PACKAGES \
        lib32gcc1 lib32stdc++6 wget binutils apache2 \
        vim zip unzip imagemagick lsof && \
    apt-get clean && \
    a2enmod php${PHP_VERSION} && \
    rm -rf /var/lib/apt/lists/* && \
    update-alternatives --set php /usr/bin/php${PHP_VERSION}

VOLUME /mc

COPY config ${CONFIG_DIR}
COPY init.sh /init.sh

RUN chmod +x /init.sh

ENV MC_DAEMON_ID="1" \
    MC_DAEMON_PW="ChangeMe" \
    MC_FTP_IP="" \
    MC_FTP_PORT="21" \
    MC_FTP_SERVER="y" \
    MC_KEY="no" \
    DEBUG=false

CMD ["/init.sh"]
