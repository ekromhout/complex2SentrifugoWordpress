FROM tier/shibboleth_sp:3.0.4_03122019

VOLUME /var/www/html

RUN mkdir /opt/tier/.wp-cli
#COPY container_files/wordpress/000-default.conf /etc/apache2/sites-available/
COPY container_files/wordpress/sed.sh /root
COPY container_files/wordpress/wp /root
COPY container_files/wordpress/config.yml /root/.wp-cli
COPY container_files/wordpress/wp-cli.yml /var/www/html

RUN chmod +x /root/wp
RUN yum update -y 
RUN yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm \
    && yum install yum-utils \
    && yum-config-manager --enable remi-php72 \
    && yum install -y php php-gd mariadb wget php-mysql postfix nc
RUN echo 'date.timezone="UTC"' >> /etc/php.ini
#RUN echo 'nameserver 127.0.0.11' > /etc/resolv.conf
RUN /etc/shibboleth/keygen.sh -o /etc/shibboleth/ -y 10 -n sp-encrypt -f \
     && /etc/shibboleth/keygen.sh -o /etc/shibboleth/ -y 10 -n sp-signing -f

#RUN cd /root \
#    && wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
#    && chmod +x wp-cli.phar

RUN cat /etc/resolv.conf
WORKDIR /var/www/html
#RUN /root/wp-cli.phar core download 
#    && sleep 3 \
#    && cat /etc/resolv.conf \
#    && cat /etc/hosts \
#    && /root/wp-cli.phar  config create --dbname=wordpress --dbuser=wordpress --dbpass=54y6RxN7GfC7aes3 --dbhost=wordpress_data2 \
#    && sleep 15 \
#    && /root/wp-cli.phar core install --url="http://localhost/" --title="wordpress" --admin_user="admin" --admin_password="54y6RxN7GfC7aes3" --admin_email="sentrifugo.container@gmail.com" --allow-root \
#    && /root/wp-cli.phar  plugin install jwt-authentication-for-wp-rest-api  --activate --allow-root \
#    && /root/wp-cli.phar  plugin install shibboleth --activate --allow-root \
#    && /root/wp-cli.phar  plugin install wp-rest-api-log --activate --allow-root

#RUN sed -i "s/<\/IfModule>/RewriteCond \%{HTTP:Authorization} \^\(\.\*\)\nRewriteRule \^\(\.\*\) - [E=HTTP_AUTHORIZATION:\%1]\n<\/IfModule>\nSetEnvIf Authorization "\(\.\*\)" HTTP_AUTHORIZATION=\$$1/" /var/www/html/.htaccess \
#    && sed -i "s/define( 'DB_COLLATE', '' );/define( 'DB_COLLATE', '' );\ndefine('JWT_AUTH_SECRET_KEY', 'your-top-secret-key');\ndefine('JWT_AUTH_CORS_ENABLE', true);\n/" /var/www/html/wp-config.php \
#    && sed -i "s/RewriteBase \//RewriteBase \/\nRewriteRule \^wp-json\/\(\.\*\) \/?rest_route=\/\$1 \[L\]\n/" /var/www/html/.htaccess 


RUN chown -R apache:apache /var/www/html
