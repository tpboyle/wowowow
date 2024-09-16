#!/bin/bash

#
# cron.sh
#   > handles cron interactions (primarily for setting up backups)
#


# CONSTANTS

working_dir="$(pwd)"
cron_dump_fn='cron_dump'


# CONFIG

backup_time="22 13 * * *"
backup_command="$(pwd)/scripts/src/backups/create.sh"


# FUNC

dump_crontab()
{
    crontab -l > $cron_dump_fn
}

flash_crontab_from_dump()
{
    crontab $cron_dump_fn
}

delete_crontab_dump()
{
    rm $cron_dump_fn
}

append_backup_task_to_dump()
{
    if ! grep -q "$backup_command" $cron_dump_fn
    then
        echo "$backup_time $backup_command $(pwd)" >> $cron_dump_fn
    fi
}

add_backup_cron_job()
{
    dump_crontab
    append_backup_task_to_dump
    flash_crontab_from_dump
    delete_crontab_dump
}

delete_backup_cron_job()
{
    dump_crontab
    sed -i "/$backup_time/d" $cron_dump_fn
    flash_crontab_from_dump
    delete_crontab_dump
}

backup_cron_job_exists()
{
    dump_crontab
    if ! grep -q "$backup_command" $cron_dump_fn
    then
        delete_crontab_dump
        return 1
    else
        delete_crontab_dump
        return 0
    fi
}


# MAIN

main()
{
    if backup_cron_job_exists
    then
        echo "Backup cron job exists!"
    else
        echo "Backup cron job does not exist!"
    fi
}
