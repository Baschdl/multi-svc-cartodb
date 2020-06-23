#!/bin/bash

#### SETTINGS FROM ENVIRONMENT ###############################################

VARNISH_HTTP_PORT=${VARNISH_HTTP_PORT}
VARNISH_STORAGE_METHOD=${VARNISH_STORAGE_METHOD}
VARNISH_STORAGE_SIZE=${VARNISH_STORAGE_SIZE}
VARNISH_TTL=${VARNISH_TTL}

REQUIRED_ENV_VARS=(VARNISH_HTTP_PORT)

REQS_MET="yes"
for var in ${REQUIRED_ENV_VARS[@]}; do
    if [[ -z ${!var} ]]; then
        echo "CRITICAL: In script ${0}, ${var} not found in environment."
        REQS_MET="no"
    fi
done

if [[ $REQS_MET != "yes" ]]; then
    echo "${0} exiting, insufficient info from env."; exit 1
fi

#### ENTRYPOINT TASKS ########################################################

echo "Starting varnishd (foregrounded) as container entrypoint."
/opt/varnish/sbin/varnishd -F \
    -a :${VARNISH_HTTP_PORT} \
    -s ${VARNISH_STORAGE_METHOD},${VARNISH_STORAGE_SIZE} \
    -f /etc/varnish.vcl \
    -p http_req_hdr_len=32768 \
    -t ${VARNISH_TTL} \
