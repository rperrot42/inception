
set -e

mkdir -p /var/run/mysqld
chown -R mysql:mysql /var/run/mysqld
cd /var/lib/mysql
chown -R mysql:mysql /var/lib/mysql

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo ">>> Initialisation du datadir..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql

    echo ">>> Démarrage temporaire de MariaDB..."
    mariadbd --user=mysql --skip-networking --socket=/var/run/mysqld/mysqld.sock &
    pid="$!"

    # Attente que le serveur réponde
    until mariadb-admin ping --socket=/var/run/mysqld/mysqld.sock >/dev/null 2>&1; do
      echo ">>> Toujours en attente que MariaDB démarre..."
      sleep 1
    done

    echo ">>> Exécution du script d'initialisation SQL..."


    echo ">>> Arrêt du MariaDB temporaire..."
    mariadb-admin --user=root --socket=/var/run/mysqld/mysqld.sock shutdown || true
    wait "$pid"
fi
mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;"
exec mariadbd --user=mysql --console

