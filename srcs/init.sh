# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    init.sh                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ivanloisy <ivanloisy@student.42.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/04 18:41:59 by ivanloisy         #+#    #+#              #
#    Updated: 2021/05/04 21:17:34 by ivanloisy        ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

service php7.3-fpm start
service nginx start
service mysql start

ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost

echo "GRANT ALL ON *.* TO 'ivloisy'@'localhost' IDENTIFIED BY '123'" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
#echo "CREATE DATABASE phpmyadmin" | mysql -u root

service nginx restart
service php7.3-fpm restart

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