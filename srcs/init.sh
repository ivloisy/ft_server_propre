# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    init.sh                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ivanloisy <ivanloisy@student.42.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/04 18:41:59 by ivanloisy         #+#    #+#              #
#    Updated: 2021/05/05 21:06:59 by ivanloisy        ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

service php7.3-fpm start
service nginx start
service mysql start

ln -s /etc/nginx/sites-available/ft_server /etc/nginx/sites-enabled/ft_server

echo "GRANT ALL ON *.* TO 'ivloisy'@'localhost' IDENTIFIED BY '123'" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
#echo "CREATE DATABASE phpmyadmin" | mysql -u root

#SETUP AND INSTALL WORDPRESS
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
cd /var/www/localhost/wordpress
wp core download --locale=fr_FR --force --allow-root
wp core version --allow-root
wp core config --dbname=localhost --dbuser=ivloisy --dbpass=123 --skip-check --extra-php --allow-root <<PHP
define( 'WP_DEBUG', true );
PHP
wp db create --allow-root
# generate password
passgen=`head -c 10 /dev/random | base64`
password=${passgen:0:10}
# install
wp core install --url="http://localhost:8080/wordpress" --title="ft_server" --admin_user=ivloisy --admin_email=ivloisy@student.42.fr --admin_password=123 --allow-root

#openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=ivloisy/CN=localhost"
#openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

service nginx restart
service php7.3-fpm restart