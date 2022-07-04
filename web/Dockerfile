ARG OS_VERSION

FROM ubuntu:${OS_VERSION}

LABEL MEINTAINER="Kensora <diligul.alex@gmail.com>"

ARG APP_USER
ARG APP_EXECUTABLE_PATH
ARG NODEJS_VERSION

ENV APP_USER=${APP_USER}
ENV APP_EXECUTABLE_PATH=${APP_EXECUTABLE_PATH}
ENV NODEJS_VERSION=${NODEJS_VERSION}
ENV NVM_DIR=/usr/local/nvm

RUN \
    # install
    apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests --assume-yes \
        sudo \
        curl \
        ca-certificates \
        supervisor \
        nginx \
        # need for envsubst
        gettext-base \
    # specific install
    && mkdir --parents ${NVM_DIR} \
        && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash \
        && . ${NVM_DIR}/nvm.sh \
        && nvm install ${NODEJS_VERSION} \
        && nvm alias default ${NODEJS_VERSION} \
        && nvm use default \
    # user setup
    && mkdir --parents /home/${APP_USER} \
    && adduser --quiet --disabled-password ${APP_USER} \
    && chown --recursive ${APP_USER}:${APP_USER} /home/${APP_USER}

COPY "./root/init.sh" "/init.sh"
COPY "./root/etc/supervisor/" "/etc/supervisor/"

ENTRYPOINT [ "/init.sh" ]
