#!/bin/bash


#
# > backups/apply.sh
#     Applies a backup of the AzerothCore database.
#     Meant to be run manually.
#

source "./_config.sh"


# FUNC

# Params:
#   $1: backup filename
apply_backup()
{
  echo "pwd: $(pwd)"
  docker run \
    --rm \
    --mount source=ac-database,target=/var/lib/mysql \
    -v "$(pwd)/backup":/backup \
    ubuntu bash -c "cd /var/lib/mysql && rm -rf * && tar xvf /backup/$1 --strip 1"
}

# Params:
#  $1: backup filename
main()
{
  apply_backup $1
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi

