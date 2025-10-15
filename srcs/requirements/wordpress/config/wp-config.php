<?php
define( 'DB_NAME', 'db1' );

define( 'DB_USER', 'user' );

define( 'DB_PASSWORD', 'pwd' );

define( 'DB_HOST', 'mariadb:3306' );

define( 'DB_CHARSET', 'utf8' );

define( 'DB_COLLATE', '' );

define( 'WP_ALLOW_REPAIR', true );

$table_prefix = 'wp_';
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
?>