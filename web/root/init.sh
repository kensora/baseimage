#!/bin/bash

username=${APP_USER:-$(whoami)}

echo "#baseimage: user ${username}"

if [[ ! -z "${APP_CMD}" ]]; then
   envsubst '${APP_CMD}' < /etc/supervisor/conf.d.template/supervisord.app.conf > /etc/supervisor/conf.d/supervisord.app.conf
fi

if [[ ! -z "${APP_PORT}" ]]; then
   envsubst < /etc/supervisor/conf.d.template/supervisord.nginx.conf > /etc/supervisor/conf.d/supervisord.nginx.conf
   envsubst '${APP_PORT}' < /etc/nginx/sites-enabled.template/default > /etc/nginx/sites-enabled/default
fi

if [[ -z "$@" ]]; then
   echo "#baseimage: start supervisor standalone"
   exec gosu root supervisord --nodaemon --configuration=/etc/supervisor/supervisord.conf
else
   echo "#baseimage: supervisor starting..."
   supervisord --configuration=/etc/supervisor/supervisord.conf
   echo "#baseimage: supervisor started"

   echo "#baseimage: execute '$@'"
   exec gosu ${username} $@
fi
