#!/bin/bash


#
# > start.sh
#     Starts the AzerothCore server.
#       Internally, wraps `docker compose up` with a backup script.
#
#     Needs to be run from the AzerothCore root folder.
#

source ./scripts/src/cron.sh

add_backup_cron_job
if backup_cron_job_exists
then
    echo "Cron job successfully created!"
    docker compose up
else
    echo "ERROR: Failed to start - backup cron job could not be created."
fi
