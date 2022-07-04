#!/bin/bash

UID=$(id -u)

APP_EXECUTABLE_PATH=${APP_EXECUTABLE_PATH} envsubst < /etc/supervisor/conf.template.d/supervisord.app.conf > /etc/supervisor/conf.d/supervisord.app.conf
/usr/bin/supervisord --configuration /etc/supervisor/supervisord.conf

if [[ ${UID} -eq 0 ]]; then
   sudo -H -u $APP_USER "$@"
else
   exec "$@"
fi
