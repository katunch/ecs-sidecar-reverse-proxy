#!/bin/sh

set -e

ME=$(basename "$0")

entrypoint_log() {
    if [ -z "${NGINX_ENTRYPOINT_QUIET_LOGS:-}" ]; then
        echo "$@"
    fi
}

substitute_nginx_config() {
    export NGINX_RATE_LIMIT_PER_SECOND=${NGINX_RATE_LIMIT_PER_SECOND:-10}
    export NGINX_RATE_LIMIT_BURST=${NGINX_RATE_LIMIT_BURST:-10}
    local conffile="/etc/nginx/nginx.conf"
    local defined_envs=$(printf '${%s} ' $(awk "END { for (name in ENVIRON) { print ( name ~ /${filter}/ ) ? name : \"\" } }" < /dev/null ))
    echo "$defined_envs"
    entrypoint_log "$ME: Substituting environment variables in $conffile"
    envsubst "$defined_envs" < "$conffile" > "${conffile}.tmp"
    mv "${conffile}.tmp" "$conffile"
}

substitute_nginx_config

exit 0
