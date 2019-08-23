#!/bin/sh
cd /var/www/html

. /etc/apache2/envvars 
if [ ! -s /var/www/html/sentrifugo/public/db_constants.php ]
then
sleep 15
while ! nc -z  sentrifugo_data 3306 ; do echo waiting for mysql on sentrifugo_data to start; sleep 3; done;
apachectl start && sleep 2 && curl -d "host=sentrifugo_data&username=sentrifugo&password=54y6RxN7GfC7aes3&dbname=sentrifugo" -H "Content-Type: application/x-www-form-urlencoded" -X POST http://localhost:80/install/step2.php && curl -data-raw "app_name=sentrifugo" -data-raw "email=sentrifugo.container@gmail.com" -H "Content-Type: application/x-www-form-urlencoded" -X POST http://localhost:80/install/step3.php
apachectl stop
mysql -h sentrifugo_data -u sentrifugo --password=54y6RxN7GfC7aes3 sentrifugo < /tmp/step3.sql
mysql -h sentrifugo_data -u sentrifugo --password=54y6RxN7GfC7aes3 sentrifugo < /tmp/step4.sql
mysql -h sentrifugo_data -u sentrifugo --password=54y6RxN7GfC7aes3 sentrifugo < /tmp/banderson.sql
cd /tmp/
/tmp
wget https://github.com/ssimicro/lib_mysqludf_amqp/releases/download/v2.0.0/lib_mysqludf_amqp-2.0.0.tar.gz
tar zxf lib_mysqludf_amqp-2.0.0.tar.gz
cd /tmp/lib_mysqludf_amqp-2.0.0
mysql -h sentrifugo_data -u root --password=54y6RxN7GfC7aes3 < installdb.sql
mysql -h sentrifugo_data -u root --password=54y6RxN7GfC7aes3 sentrifugo  < /tmp/trigger.sql
mysql -h sentrifugo_data -u sentrifugo --password=54y6RxN7GfC7aes3 sentrifugo < /tmp/step5.sql
mv /var/www/html/sentrifugo/install /var/www/html/sentrifugo/install.old
echo database initialization complete
fi

exec apache2 -DNO_DETACH < /dev/null
