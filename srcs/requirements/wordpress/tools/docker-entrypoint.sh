set -e

chmod 777  /usr/local/bin/
cd /var/www/html
find .  -maxdepth 1  ! -name 'wp-config.php' ! -name '.' -exec rm -rf {} +

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar


chmod +x wp-cli.phar


mv wp-cli.phar /usr/local/bin/wp


sed -i -r "s/db1/$MYSQL_DATABASE/1" wp-config.php
sed -i -r "s/user/$MYSQL_USER/1" wp-config.php
sed -i -r "s/pwd/$MYSQL_PASSWORD/1" wp-config.php


wp core download --path=/var/www/html/ --allow-root

if [ ! -f /var/www/wordpress/wp-config.php ]; then
    wp core install --url=$DOMAIN_NAME --title="$WP_TITLE" \
        --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD \
        --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root \
         --path=/var/www/html
fi


if ! wp user get $WP_USR --quiet --allow-root; then
    wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root
fi

wp theme install astra --activate --allow-root

php -v

sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = 9000/g' /etc/php/8.2/fpm/pool.d/www.conf

mkdir -p /run/php


/usr/sbin/php-fpm8.2 -F