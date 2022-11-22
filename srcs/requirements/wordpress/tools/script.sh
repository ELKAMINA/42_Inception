#!/bin/sh

# wait for mysql
while ! mariadb -h$MYSQL_HOST -u$WP_DATABASE_USER -p$WP_DATABASE_PWD $WP_DATABASE_NAME &>/dev/null; do
    sleep 5
done

if [ ! -f "/var/www/html/index.html" ]; then
    # static website
   # mv /tmp/index.html /var/www/html/index.html
    # adminer
	wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql-en.php -O /var/www/html/adminer.php &> /dev/null
	wget https://raw.githubusercontent.com/Niyko/Hydra-Dark-Theme-for-Adminer/master/adminer.css -O /var/www/html/adminer.css &> /dev/null
	wp core download --path=/var/www/html --allow-root
	wp config create --dbname=$WP_DATABASE_NAME --dbuser=$WP_DATABASE_USER --dbpass=$WP_DATABASE_PWD --dbhost=$MYSQL_HOST --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
	wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
	wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root

	wp plugin update --all --allow-root

fi

echo "STARTING WORDPRESS ON 9000 PORT"
/usr/sbin/php-fpm7 -F -R
