#!/bin/bash

CONFIG_FILE="config/environments/${SQLAPI_ENVIRONMENT}.js"
set -e

echo "Starting the SQLAPI node application..."
exec node app -c "$CONFIG_FILE"
