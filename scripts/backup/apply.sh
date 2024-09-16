#!/bin/bash

#
# > backup/apply.sh
#     Applies a backup of the AzerothCore database.
#       Meant to be run manually.
#


# SETUP

# Force the current directory to be the root directory
#   Repeated here since we can't source until we correct the working directory.
script_dir="$(dirname "$(readlink -fm "$0")")"
root_dir="$script_dir/../.."
cd "$root_dir"


# SOURCES

source "./scripts/src/log.sh"
source "./scripts/src/server.sh"

source "./scripts/backup/_config.sh"
source "./scripts/backup/_prep.sh"


# FUNC

# Params:
#   $1: backup filename
apply_backup()
{
  filename=$1
  log_info "Applying backup '$filename'..."
  docker run \
    --rm \
    --mount source=ac-database,target=/var/lib/mysql \
    -v "$(pwd)/backups":/backups \
    ubuntu bash -c "cd /var/lib/mysql && rm -rf * && tar xvf /backups/$filename --strip 1" \
      > /dev/null
}


# MAIN

# Params:
#  $1: backup filename (e.g. '2024-09-17_12-04-46.tar')
main()
{
  # Assumes that we are running from the root directory (guaranteed by setup)
  filename=$1
  apply_backup $filename
  restart_ac_if_requested $*    # src/server.sh
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi
