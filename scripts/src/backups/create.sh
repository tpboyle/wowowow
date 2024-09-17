#!/bin/bash


#
# > backups/create.sh
#     Creates a backup of the AzerothCore database.
#     Meant to be run either as a cron job or manually.
#
#     Params:
#       $1: working directory (default to "$(pwd)")
#

source "./scripts/src/backups/_config.sh"
source "./scripts/src/backups/_common.sh"


# FUNC

run_backup()
{
  docker run \
    --rm \
    --mount source=wowowow_ac-database,target=/var/lib/mysql \
    -v "$(pwd)/backup":/backup \
    ubuntu bash -c "cd /var/lib/mysql && tar cvf /backup/$(date "+%Y-%m-%d_%H-%M-%S").tar ."
      # FIXME - datetime format hardcoded
}

prepare_for_backup()
{
  stop_ac
}

# Effects:
#   Stops AzerothCore while backing up.
# Params:
#   $1: AzerothCore directory
# Flags:
#   --restart: request server restart after backup
main()
{
  set_working_directory $1
  prepare_for_backup
  run_backup
  restart_ac_if_requested $*
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi
