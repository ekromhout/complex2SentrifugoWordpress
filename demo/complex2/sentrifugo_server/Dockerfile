FROM ubuntu:16.04
MAINTAINER Sreekanth G S <mail@sreekanth.in>
#ENV http_proxy=http://sysfp0t.its.unc.edu:80
#ENV https_proxy=http://sysfp0t.its.unc.edu:80
#RUN DEBIAN_FRONTEND=noninteractive \
#    apt-get -o Acquire::http::Proxy="http://sysfp0t.its.unc.edu:80"  update && \
#    apt-get -o Acquire::http::Proxy="http://sysfp0t.its.unc.edu:80" install -y language-pack-en-base &&\
#    export LC_ALL=en_US.UTF-8 && \
#`    export LANG=en_US.UTF-8


RUN DEBIAN_FRONTEND=noninteractive apt-get update   && apt-get install -y  software-properties-common
#RUN cat /etc/locale.gen
#RUN cat /etc/environment
#RUN LANG=en_US.UTF-8 locale-gen --purge en_US.UTF-8 &&  echo -e 'LANG="en_US.UTF-8"\nLANGUAGE="en_US:en"\n' > /etc/default/locale && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen &&  echo "LC_ALL=en_US.UTF-8" > /etc/environment &&  echo "LANG=en_US.UTF-8" >> /etc/environment &&  locale-gen "en_US.UTF-8"  && export LC_ALL=en_US.UTF-8 && export LANG=en_US.UTF-8 &&  add-apt-repository ppa:ondrej/php

#RUN apt-get -o Acquire::http::Proxy="http://sysfp0t.its.unc.edu:80"  update && apt-get -o Acquire::http::Proxy="http://sysfp0t.its.unc.edu:80" install -y software-properties-common language-pack-en-base && \
#LC_ALL=C.UTF-8  add-apt-repository  ppa:ondrej/php && apt-get -o Acquire::http::Proxy="http://sysfp0t.its.unc.edu:80" update && apt-get -o Acquire::http::Proxy="http://sysfp0t.its.unc.edu:80" install -y \
RUN echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu xenial main" >> /etc/apt/sources.list && echo "deb-src http://ppa.launchpad.net/ondrej/php/ubuntu xenial main" >> /etc/apt/sourceis.list && apt-get update --allow-unauthenticated
RUN cat /etc/apt/sources.list && ls -l /etc/apt/
RUN apt-get  install -y --allow-unauthenticated apache2-bin libapache2-mod-php php-curl php-ldap php-mysql php-mcrypt \
php-gd php-xml patch curl vim git mysql-client wget unzip lynx netcat

RUN phpenmod mcrypt && phpenmod gd
RUN a2enmod xml2enc && a2enmod rewrite

RUN sed -i 's/variables_order = .*/variables_order = "EGPCS"/' /etc/php/7.3/apache2/php.ini
RUN sed -i 's/variables_order = .*/variables_order = "EGPCS"/' /etc/php/7.3/cli/php.ini

RUN useradd --uid 1000 --gid 50 docker

RUN echo export APACHE_RUN_USER=docker >> /etc/apache2/envvars
RUN echo export APACHE_RUN_GROUP=staff >> /etc/apache2/envvars

COPY 000-default.conf /etc/apache2/sites-enabled/000-default.conf

RUN chown -R docker /var/www/html

WORKDIR /var/www/html

RUN wget -q "http://www.sentrifugo.com/home/downloadfile?file_name=Sentrifugo.zip" -O Sentrifugo.zip 
#COPY Sentrifugo.zip /var/www/html/
RUN unzip Sentrifugo.zip && mv Sentrifugo_3.2 sentrifugo

WORKDIR /var/www/html/sentrifugo
RUN chown -R docker .

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

RUN chmod 777 -R public/downloads public/uploads public/email_constants.php \
public/emptabconfigure.php \
public/site_constants.php \
public/db_constants.php \
public/application_constants.php \
public/mail_settings_constants.php \
logs/application.log \
application/modules/default/plugins/AccessControl.php \
install


VOLUME /var/www/html/sentrifugo/public/uploads

VOLUME /var/www/html/sentrifugo/public/downloads
#VOLUME /var/www/html/sentrifugo
#RUN apachectl start && sleep 2 && curl -d "host=mariadb&username=sentrifugo&password=54y6RxN7GfC7aes3&dbname=sentrifugo" -H "Content-Type: application/x-www-form-urlencoded" -X POST http://localhost:80/install/step2.php && curl -data-raw "app_name=sentrifugo" -data-raw "email=sentrifugo.container@gmail.com" -H "Content-Type: application/x-www-form-urlencoded" -X POST http://localhost:80/install/step3.php
#RUN apachectl stop
COPY application_constants.php /var/www/html/sentrifugo/public
COPY mail_settings_constants.php /var/www/html/sentrifugo/public
COPY step3.sql /tmp
COPY step4.sql /tmp
COPY step5.sql /tmp
COPY trigger.sql /tmp
COPY banderson.sql /tmp

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 80
