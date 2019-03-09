FROM quay.io/spivegin/apache

WORKDIR /var/www/html 

RUN apt-get update &&\
    apt-get install -y wget git zip default-libmysqlclient-dev libbz2-dev libmemcached-dev libsasl2-dev libfreetype6-dev libicu-dev libjpeg-dev libmemcachedutil2 libpng-dev libxml2-dev mariadb-client ffmpeg libimage-exiftool-perl python curl python-pip && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include --with-jpeg-dir=/usr/include && \
    docker-php-ext-install -j$(nproc) bcmath bz2 calendar exif gd gettext iconv intl mbstring mysqli opcache pdo_mysql zip php7.0-zip && \
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* &&\
    a2enmod rewrite

RUN rm -rf /var/www/html/* &&\
    git clone https://github.com/DanielnetoDotCom/YouPHPTube.git . &&\
    install -d -m 0755 -o www-data -g www-data /var/www/html/videos &&\
    chown -R www-data:www-data .


EXPOSE 80
ADD files/apache2/sites-enabled/00-default.conf /etc/apache2/sites-enabled/
ADD files/php/php.ini /etc/php/7.0/apache2/
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/bin/entry.sh"]