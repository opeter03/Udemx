#!/bin/sh
#MySQL database backup script

MYSQL="$(which mysql)"
MYSQLDUMP="$(which mysqldump)"

BACKUPDIR="/var/backups/databases"
NOW=$(date +"%Y-%m-%d")

MYCONFIG=" --defaults-file=/root/.my.cnf "
MYCONFIG_BACKUP=" --defaults-file=/root/.my.cnf --opt -Q  -B --routines --triggers"

#Backup könyvtár létrehozása rekurzívan, ha nem létezik
[ ! -d $BACKUPDIR/$NOW ] && mkdir -p $BACKUPDIR/$NOW || :

#Végig megyünk az összes adatbázison kivéve a rendszerét
for db in `mysql $MYCONFIG -e "show databases" | tail -n +2 | grep -v information_schema | grep -v performance_schema`; do
    FILE=$BACKUPDIR/$NOW/$db.sql

    #Dump készítés
    if [ ! -f $FILE ]; then
        $MYSQLDUMP $MYCONFIG_BACKUP $db -e > $FILE
    fi
done
