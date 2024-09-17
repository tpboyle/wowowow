#!/bin/bash

#
# > log.sh
#   Exposes log interface.
#


# FUNC

# Params:
#   $1: type (e.g. "INFO")
#   $2: message
log()
{
  type="$1"
  message="$2"
  timestamp=$(date "+%Y-%m-%d %H:%M:%S")
  echo "$timestamp: $type: $message"
}

# INTERFACE

# Params:
#   $1: message
log_info()
{
  message="$1"
  log "INFO" "$message"
}

# Params:
#   $1: message
log_error()
{
  message="$1"
  log "ERROR" "$message"
}
