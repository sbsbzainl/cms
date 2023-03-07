FROM ubuntu:14.04

MAINTAINER yoyo <https://github.com/sbsbzainl>

# 使用国内淘宝源file:///home/kali/Desktop/start.sh

ADD sources.list /etc/apt/

# 安装服务
RUN apt-get -y update \
  && apt-get -y --no-install-recommends install php5 php5-mysqlnd php5-gd mariadb-server wget unzip curl supervisor

WORKDIR /var/www/html/

# 修改 php.ini
RUN sed -i 's/allow_url_include = Off/allow_url_include = On/g' /etc/php5/apache2/php.ini

ADD BEES.zip /var/www/html/
ADD ./start.sh /var/www/html/start.sh
RUN unzip BEES.zip \
  && chown www-data:www-data -R /var/www/html \
  && rm -f BEES.zip \
  && rm -rf /var/www/html/index.html\
  && echo "ServerName localhost:80">> /etc/apache2/apache2.conf\
  && chmod 777 /var/www/html/start.sh
#CMD service mysql start
#RUN sleep 3
#CMD service apache2 start
#RUN sleep 3
#RUN ln –s /data/mysql/mysql.sock /var/lib/mysql/
#RUN mysql  -u root -p  -e "CREATE USER 'dees'@'localhost' IDENTIFIED BY 'dees'; GRANT ALL privileges ON *.* TO 'dees'@'localhost'; CREATE DATABASE beescms18;use beescms18; source /var/www/html/install/data/data.sql;"

EXPOSE 80 3306 
#COPY main.sh /
#ENTRYPOINT ["/main.sh"]
#COPY ./start.conf /etc/supervisor/conf.d/start.conf
#CMD ["/usr/bin/supervisord"]
CMD ["sh", "/var/www/html/start.sh"]
#ENTRYPOINT ["/var/www/html/start.sh"]


