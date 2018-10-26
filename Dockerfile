FROM debian:jessie
RUN apt-get -y update
# install programs
RUN apt-get install -y apache2 php5 php5-cli php5-gd php5-json php5-redis php5-mysql php5-curl mysql-client
RUN apt-get clean
###################
# install apache2

# turn off some apache modules
RUN rm /etc/apache2/mods-enabled/status.conf
RUN rm /etc/apache2/mods-enabled/status.load
RUN rm /etc/apache2/mods-enabled/autoindex.conf
RUN rm /etc/apache2/mods-enabled/autoindex.load
RUN rm /etc/apache2/mods-enabled/alias.conf
RUN rm /etc/apache2/mods-enabled/alias.load

# turn on some apache modules
RUN ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load
COPY apache2.conf /etc/apache2/apache2.conf
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

# create apache enviroment file

COPY envvars /etc/apache2/envvars

COPY php.ini /etc/php5/apache2/php.ini

RUN mkdir /apache/
RUN mkdir /apache/conf/
RUN mkdir /apache/log/
RUN mkdir /apache/tmp/
RUN mkdir /apache/source/
RUN mkdir /apache/source/default/
RUN mkdir /apache/source/default/html/
RUN chmod -r /apache/source/*

COPY index.html.default /apache/source/default/html/index.html

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
