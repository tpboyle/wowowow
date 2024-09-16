#!/bin/bash


#
# > stop.sh
#     Stops the AzerothCore server.
#       Internally, wraps `docker compose down` with a backup script.
#
#     Needs to be run from the AzerothCore root folder.
#

source ./scripts/src/cron.sh

delete_backup_cron_job
if backup_cron_job_exists
then
    echo "ERROR: backup cron job could not be deleted."
fi
docker compose down
