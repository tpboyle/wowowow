
# Params:
#   $1: AzerothCore directory
set_working_directory()
{
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

restart_ac()
{
  stop_ac
  start_ac
}

# Params:
#   $*: pass all params so flag can be found
restart_ac_if_requested()
{
  if [[ $* == *--restart* ]]
  then
    restart_ac
  fi
}
