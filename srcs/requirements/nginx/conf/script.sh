#!/bin/bash

export DOLLAR='$'

envsubst < /tmp/nginx.conf.template > /etc/nginx/conf.d/nginx.conf

nginx -g "daemon off;"