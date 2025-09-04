set -e

# Initialiser la base de données si nécessaire
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB database..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

chown -R mysql:mysql /var/lib/mysql

echo "Starting MariaDB..."
exec mysqld --user=mysql --datadir=/var/lib/mysql