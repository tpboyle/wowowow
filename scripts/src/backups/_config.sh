#!/bin/bash


# CONSTANTS

database_dir='/var/lib/mysql'
database_container='ac-database'
backup_command="docker cp $database_container:$database_dir "


# CONFIG

backup_dir="./backups"
datetime_format="%Y-%m-%d_%H-%M-%S"

