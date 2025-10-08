<?php
define( 'DB_NAME', 'db1' );

/** MySQL database username */
define( 'DB_USER', 'user' );

/** MySQL database password */
define( 'DB_PASSWORD', 'pwd' );

/** MySQL hostname */
define( 'DB_HOST', 'mariadb:3306' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

define( 'WP_ALLOW_REPAIR', true );

define( 'AUTH_KEY',         'mettre_une_cle_unique' );
define( 'SECURE_AUTH_KEY',  'mettre_une_cle_unique' );
define( 'LOGGED_IN_KEY',    'mettre_une_cle_unique' );
define( 'NONCE_KEY',        'mettre_une_cle_unique' );
define( 'AUTH_SALT',        'mettre_une_cle_unique' );
define( 'SECURE_AUTH_SALT', 'mettre_une_cle_unique' );
define( 'LOGGED_IN_SALT',   'mettre_une_cle_unique' );
define( 'NONCE_SALT',       'mettre_une_cle_unique' );

$table_prefix = 'wp_';
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
?>