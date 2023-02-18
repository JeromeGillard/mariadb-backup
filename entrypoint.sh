#!/bin/bash
echo "Backup script started. DB host=${BACKUP_DB_HOST} user=${BACKUP_DB_USER} keep ${BACKUP_NUM_KEEP} backups, executes every ${BACKUP_FREQUENCY} seconds."
trap "break;exit" SIGHUP SIGINT SIGTERM
sleep 2
while /bin/true; do
  FN=`date +%d-%m-%Y"_"%H_%M_%S`
  ARCHIVE_NAME=`echo "/dump/dump_\${FN}.sql.gz"`
  echo "Start backup into ${ARCHIVE_NAME}"
  mysqldump -h ${BACKUP_DB_HOST} -u ${BACKUP_DB_USER} -p${BACKUP_DB_PASSWORD} --all-databases > dump.sql || break
  cat dump.sql | gzip -c > ${ARCHIVE_NAME}
  rm dumpl.sql
  ls -tr /dump/dump_*.sql.gz | head -n -"${BACKUP_NUM_KEEP}" | xargs -r rm
  ls -al ${ARCHIVE_NAME}
  echo "Backup successfuly exported at ${ARCHIVE_NAME}. Sleeping for ${BACKUP_FREQUENCY}"
  sleep ${BACKUP_FREQUENCY}
done
echo "Error. Exiting container."
exit 1