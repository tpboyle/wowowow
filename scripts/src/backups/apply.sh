#!/bin/bash


#
# > backups/apply.sh
#     Applies a backup of the AzerothCore database.
#     Meant to be run manually.
#

source "./_config.sh"


# FUNC

# Params:
#   $1: AzerothCore directory
apply_backup()
{
  # TODO - test
  docker run \
    --rm \
    --volumes-from ac-database \
    -v "$1"/backup:/backup \
    ubuntu bash -c "cd /dbdata && tar xvf /backup/backup.tar --strip 1"
}

# Params:
#  $1: ...
main()
{
  # TODO
}
