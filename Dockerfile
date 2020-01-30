FROM ubuntu
RUN apt-get update
RUN apt-get -y install rsyslog
RUN apt-get install -y tzdata -y
RUN ln -fs /usr/share/zoneinfo/Europe/Budapest /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:ondrej/php
RUN apt-get update
RUN apt-get install -y php5.6 php5.6-mysql php5.6-zip php5.6-cli php5.6-xml php5.6-mbstring
#RUN apt-get install mc -y
RUN apt-get install apache2 -y



#RUN apt-get install php-ssh2 -y
#RUN apt-get install php7.1 -y
#RUN apt-get install php-mysql -y
#RUN apt-get install php7.2-ldap php7.2-xml php7.2-zip -y
#RUN apt-get install libapache2-mod-php -y
#RUN apt-get install curl php-cli php-mbstring git unzip -y
#RUN apt-get install mysql-client -y
#RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
#RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer

RUN ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load
RUN ln -s /etc/apache2/mods-available/headers.load /etc/apache2/mods-enabled/headers.load
COPY .bashrc /root/.bashrc
COPY apache.conf /etc/apache2/sites-available/000-default.conf

#RUN composer global require laravel/lumen-installer

WORKDIR /var/www/

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
