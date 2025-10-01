
set -e

mkdir -p /var/run/mysqld
chown -R mysql:mysql /var/run/mysqld

if [ ! -d "/var/lib/mysql/mysql" ]; then

    mariadb-install-db --user=mysql --datadir=/var/lib/mysql

      mariadbd --user=mysql --skip-networking --socket=/var/run/mysqld/mysqld.sock &
      pid="$!"

    until mysqladmin ping --socket=/var/run/mysqld/mysqld.sock >/dev/null 2>&1; do
      echo "Toujours en attente..."
      sleep 1
    done

    mysql -u root --socket=/var/run/mysqld/mysqld.sock <<'EOF'
CREATE DATABASE IF NOT EXISTS {$MYSQL_DATABASE};
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON {$MYSQL_DATABASE}.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF

    kill "$pid"
    wait "$pid"

fi
exec mariadbd --user=mysql --console

