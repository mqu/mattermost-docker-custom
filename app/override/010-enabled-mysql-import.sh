#/bin/sh

# use this script to import Mysql database from /srv/mattermost.sql
# to enable this script, rename it to : 010-enabled-mysql-import.sh

wait_mysql() {
  # Wait for database to be reachable
  echo "Wait until database $DB_HOST:$DB_PORT_NUMBER is ready..."
  until nc -z $DB_HOST $DB_PORT_NUMBER
  do
    echo -n "."
    sleep 1
  done
  echo ""
  echo "DONE ; database ready"  
}

echo "# --- $0 ---"
wait_mysql

# if /srv/mattermost.sql import slq database before running mattermost
# avoid importing multiple time : create a /srv/.mattermost.sql
[ -f /srv/mattermost.sql ] && [ ! -f /srv/.mattermost.sql ] && \
    echo "importing /srv/mattermost.sql" && \
    mysql \
    -h ${DB_HOST} \
    -P ${DB_PORT_NUMBER} \
    -u ${MM_USERNAME} \
    -p${MM_PASSWORD} \
    ${MM_DBNAME} < /srv/mattermots.sql && touch /srv/.mattermost.sql

# same task with .bz2 file
[ -f /srv/mattermost.sql.bz2 ] && [ ! -f /srv/.mattermost.sql.bz2 ] && \
   echo "importing /srv/mattermost.sql.bz2" && \
   bzip2 -dc /srv/mattermost.sql.bz2 | mysql  \
   -h ${DB_HOST} \
   -P ${DB_PORT_NUMBER} \
   -u ${MM_USERNAME} \
   -p${MM_PASSWORD} \
   ${MM_DBNAME}  && touch /srv/.mattermost.sql.bz2


