#!/usr/bin/bash

BASE=/opt/projects/cpantesters
LOG=$BASE/cron/cpanstats-web1.log

date_format="%Y/%m/%d %H:%M:%S"
echo `date +"$date_format"` "START" >>$LOG

cd $BASE/cpandevel
mkdir -p logs

echo `date +"$date_format"` "Creating Devel site" >>$LOG
perl bin/cpandevel-writepages -c=data/settings.ini >>$LOG 2>&1
echo `date +"$date_format"` "Created Devel site" >>$LOG

cd $BASE/cpanstats
mkdir -p logs
mkdir -p data

perl bin/getmailrc.pl

echo `date +"$date_format"` "Creating cpanstats site" >>$LOG
perl bin/cpanstats-writepages   	\
     --config=data/settings.ini		\
     --database=../db/cpanstats.db 	\
     --logclean=1                       \
     --basics --update --stats --leader >>$LOG 2>&1

#     --logfile=$LOG			\
#     --logclean=1			\

echo `date +"$date_format"` "Creating cpanstats graphs" >>$LOG
perl bin/cpanstats-writegraphs		\
     --config=data/settings.ini         >>$LOG 2>&1

#cd $BASE/cpanstats-excel
#mkdir -p logs
#
#echo `date +"$date_format"` "Creating cpanstats excel files" >>$LOG
#perl bin/cpanstats-writeexcel >>$LOG 2>&1

echo `date +"$date_format"` "STOP" >>$LOG

