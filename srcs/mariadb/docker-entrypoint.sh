set -e

# condition pour savoir si le dossier mysql existe
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB database..."
    #création d'un utilisateur
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

chown -R mysql:mysql /var/lib/mysql

echo "Starting MariaDB..."
exec mysqld --user=mysql --datadir=/var/lib/mysql