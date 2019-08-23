from mariadb:latest
RUN apt-get update
RUN apt-get install wget gcc libmysql++-dev librabbitmq-dev pkg-config libbsd-dev -y
#ENV MYSQL_RANDOM_ROOT_PASSWORD=true
ENV MYSQL_ROOT_PASSWORD=54y6RxN7GfC7aes3
ENV MYSQL_DATABASE=sentrifugo
ENV MYSQL_USER=sentrifugo
ENV MYSQL_PASSWORD=54y6RxN7GfC7aes3
WORKDIR /tmp
RUN wget https://github.com/ssimicro/lib_mysqludf_amqp/releases/download/v2.0.0/lib_mysqludf_amqp-2.0.0.tar.gz
RUN tar zxf lib_mysqludf_amqp-2.0.0.tar.gz
WORKDIR /tmp/lib_mysqludf_amqp-2.0.0
RUN ./configure  && make  && make install #mysql -u root --password=54y6RxN7GfC7aes3 < installdb.sql
EXPOSE 3306
