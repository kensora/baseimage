ARG OS_VERSION

FROM ubuntu:${OS_VERSION}

LABEL MEINTAINER="Kensora <diligul.alex@gmail.com>"

ARG APP_USER \
    APP_PORT \
    APP_CMD

ENV APP_USER=${APP_USER} \
    APP_PORT=${APP_PORT} \
    APP_CMD=${APP_CMD} \
    DEBIAN_FRONTEND="noninteractive"

RUN \
    # install
    apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests --assume-yes \
        sudo \
        gosu \
        curl \
        build-essential \
        vim \
        ca-certificates \
        supervisor \
        nginx \
        # need for envsubst
        gettext-base \
    # user setup
    && mkdir --parents /home/${APP_USER} \
    && adduser --quiet --disabled-password ${APP_USER} \
    && chown --recursive ${APP_USER}:${APP_USER} /home/${APP_USER}

ADD "./root/init.sh" "/init.sh"
ADD "./root/etc/nginx/" "/etc/nginx/"
ADD "./root/etc/supervisor/" "/etc/supervisor/"
ADD "./root/usr/local/bin/get-nodejs.sh" "/usr/local/bin/get-nodejs"

ENTRYPOINT [ "/init.sh" ]
