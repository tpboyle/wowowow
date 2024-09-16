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


# FUNC

run_backup()
{
  echo "pwd: $(pwd)"
  docker run \
    --rm \
    --volumes-from ac-database \
    -v "$(pwd)/backup":/backup \
    ubuntu tar cvf /backup/$(date "+%Y-%m-%d_%H-%M-%S").tar /var/lib/mysql
      # FIXME - datetime format hardcoded
}

# Params:
#   $1: AzerothCore directory
set_working_directory()
{
  echo "\$1: $1"
  if [ -e $1 ]
  then
    cd "$1"
  fi
}

start_ac()
{
  docker compose up
}

start_db()
{
  docker compose up -d ac-database
}

stop_ac()
{
  docker compose down
}

prepare_for_backup()
{
  stop_ac
  start_db
}

restart_ac()
{
  stop_ac
  start_ac
}

# Effects:
#   Stops AzerothCore while backing up.
# Params:
#   $1: AzerothCore directory
main()
{
  set_working_directory $1
  prepare_for_backup
  run_backup
  restart_ac
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi