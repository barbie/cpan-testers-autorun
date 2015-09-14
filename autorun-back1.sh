#!/usr/bin/bash

BASE=/opt/projects/cpantesters
LOCK=$BASE/cpanstats-back1.lock
LOG=$BASE/cron/autorun-back1.log

date_format="%Y/%m/%d %H:%M:%S"

cd $BASE

if [ -f $LOCK ]
then
    echo `date +"$date_format"` "Backup 1 already running" >>$LOG
else
    touch $LOCK

    echo `date +"$date_format"` "START" >>$LOG

    cd $BASE/dbx

    DATE=`date +"%Y%m%d"`

    mysqldump -u barbie --skip-add-locks --add-drop-table --skip-disable-keys --skip-extended-insert cpanstats >cpanstats-backup-$DATE.sql
    bzip2 cpanstats-backup-$DATE.sql

    #mysqldump -u barbie --skip-add-locks --where="id> 14000000 AND id<=16000000" --skip-disable-keys --skip-extended-insert metabase metabase >metabase-16m-backup-$DATE.sql
    #bzip2 metabase-16m-backup-$DATE.sql
    mysqldump -u barbie --skip-add-locks --where="id> 16000000" --skip-disable-keys --skip-extended-insert metabase metabase >metabase-backup-$DATE.sql
    bzip2 metabase-backup-$DATE.sql

    mysqldump -u barbie --skip-add-locks --add-drop-table --skip-disable-keys --skip-extended-insert metabase testers_email >metabase-email-backup-$DATE.sql
    bzip2 metabase-email-backup-$DATE.sql

    cp ../db/cpanstats.db cpanstats-$DATE.db
    bzip2 cpanstats-$DATE.db

    echo `date +"$date_format"` "STOP" >>$LOG

    rm $LOCK
fi
