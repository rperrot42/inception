set -e

until mysqladmin ping -h mariadb -P3306 -u"$ROOT_USER" -p"$MYSQL_ROOT_PASSWORD" --silent; do
    echo "Waiting for MySQL..."
    sleep 1
done

chmod 777  /usr/local/bin/
cd /var/www/html

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar


chmod +x wp-cli.phar


mv wp-cli.phar /usr/local/bin/wp




if [ ! -f /var/www/html/wp-config.php ]; then
  wp core download --path=/var/www/html/ --allow-root
    wp config create --dbname=$MYSQL_DATABASE \
    --dbuser=$MYSQL_USER \
    --dbpass=$MYSQL_PASSWORD \
    --dbhost=mariadb:3306 \
    --dbprefix=wp_ \
    --allow-root \

    wp core install --url=$DOMAIN_NAME --title="$WP_TITLE" \
        --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD \
        --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root \
         --path=/var/www/html

fi


if ! wp user get $WP_USR --quiet --allow-root; then
    wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root
fi

wp theme install astra --activate --allow-root

wp option update comment_moderation 0  --allow-root

wp option update comment_whitelist 0  --allow-root

sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = 9000/g' /etc/php/8.2/fpm/pool.d/www.conf



mkdir -p /run/php

/usr/sbin/php-fpm8.2 -F