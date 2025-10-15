
set -e

mkdir -p /var/run/mysqld
chown -R mysql:mysql /var/run/mysqld

cd /var/lib/mysql
if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then


chown -R mysql:mysql /var/lib/mysql

mariadb-install-db --user=mysql --datadir=/var/lib/mysql

mariadbd --user=mysql --skip-networking --socket=/var/run/mysqld/mysqld.sock &
pid="$!"

# Attente que le serveur réponde
until mariadb-admin ping --socket=/var/run/mysqld/mysqld.sock >/dev/null 2>&1; do
  sleep 1
done
mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;"
mariadb-admin --user=root --socket=/var/run/mysqld/mysqld.sock shutdown || true
wait "$pid"
fi

exec mariadbd --user=mysql --console

