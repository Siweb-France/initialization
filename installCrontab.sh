#!/bin/bash

directory="$(dirname $0)"

crontab "$directory/default_cron.txt"

