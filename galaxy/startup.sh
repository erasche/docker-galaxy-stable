#!/bin/bash

cd /galaxy-central/
# If /export/ is mounted, export_user_files file moving all data to /export/
# symlinks will point from the original location to the new path under /export/
# If /export/ is not given, nothing will happen in that step
python ./export_user_files.py $PG_DATA_DIR_DEFAULT

# Configure SLURM with runtime hostname.
python /usr/sbin/configure_slurm.py

/usr/bin/supervisord
sleep 5

if [ `echo $GALAXY_LOGGING | tr [:upper:] [:lower:]` = "full" ]
    then 
        tail -f /root/*.log /var/log/supervisor/*
    else
        tail -f /root/*.log
fi
