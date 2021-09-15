FROM php:7.4-apache-buster

LABEL maintainer="Austin Songer" mail="austin@songer.pro"

ARG HTTPD_USER=www-data
ARG LATEST="https://downloadseramba.s3-eu-west-1.amazonaws.com/CommunityTGZ/latest.tgz"
ARG ERAMBA_DIR=eramba_community

WORKDIR /

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -yq install \
        wkhtmltopdf \
        libzip-dev \
        libbz2-ocaml-dev \
        libpng-dev \
        libldap2-dev \
        libicu-dev \
        libfreetype6-dev \
        libjpeg-dev && \
    # Required PHP extensions
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install -j$(nproc) zip bz2 gd exif ldap intl pdo_mysql

RUN curl ${LATEST} -o latest.tgz && \
    tar -zxvf /latest.tgz -C /var/www/html/ && \
    mv /var/www/html/${ERAMBA_DIR}/* /var/www/html/${ERAMBA_DIR}/.htaccess /var/www/html/ && \
    rm -r /var/www/html/${ERAMBA_DIR} /latest.tgz && \
    chown ${HTTPD_USER}:${HTTPD_USER} /var/www/html/* 
    
    # Configure php.ini following the Eramba's requirements
RUN mv $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini && \
    sed -i '/^;memory_limit /s/^;//' $PHP_INI_DIR/php.ini && \
    sed -i 's/^\(memory_limit\s*=\s*\).*$/\14096M/' $PHP_INI_DIR/php.ini && \
    sed -i '/^;post_max_size /s/^;//' $PHP_INI_DIR/php.ini && \
    sed -i 's/^\(post_max_size\s*=\s*\).*$/\1300M/' $PHP_INI_DIR/php.ini && \
    sed -i '/^;upload_max_filesize /s/^;//' $PHP_INI_DIR/php.ini && \
    sed -i 's/^\(upload_max_filesize\s*=\s*\).*$/\1300M/' $PHP_INI_DIR/php.ini && \
    sed -i '/^;max_execution_time /s/^;//' $PHP_INI_DIR/php.ini && \
    sed -i 's/^\(max_execution_time\s*=\s*\).*$/\1300/' $PHP_INI_DIR/php.ini && \
    sed -i '/^;max_input_vars /s/^;//' $PHP_INI_DIR/php.ini && \
    sed -i 's/^\(max_input_vars\s*=\s*\).*$/\13000/' $PHP_INI_DIR/php.ini && \
    sed -i '/^;max_input_time /s/^;//' $PHP_INI_DIR/php.ini && \
    sed -i 's/^\(max_input_time\s*=\s*\).*$/\1600/' $PHP_INI_DIR/php.ini && \
    ln -s /usr/bin/wkhtmltopdf /usr/local/bin/wkhtmltopdf && \
    # Enable Apache required mdoules
    ln -sf /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/ && \
    ln -sf /etc/apache2/mods-available/ssl.conf /etc/apache2/mods-enabled/ && \
    ln -sf /etc/apache2/mods-available/ssl.load /etc/apache2/mods-enabled/ && \
    ln -sf /etc/apache2/mods-available/setenvif.conf /etc/apache2/mods-enabled/ && \
    ln -sf /etc/apache2/mods-available/setenvif.load /etc/apache2/mods-enabled/ && \
    ln -sf /etc/apache2/mods-available/mime.conf /etc/apache2/mods-enabled/ && \
    ln -sf /etc/apache2/mods-available/mime.load /etc/apache2/mods-enabled/ && \
    ln -sf /etc/apache2/mods-available/socache_shmcb.load /etc/apache2/mods-enabled/ && \
    # Secure Apache
    sed -i 's/^\(ServerTokens\s*\).*$/\1Prod/' /etc/apache2/conf-enabled/security.conf && \
    sed -i 's/^\(ServerSignature\s*\).*$/\1Off/' /etc/apache2/conf-enabled/security.conf && \
    sed -i 's/^\(TraceEnable\s*\).*$/\1Off/' /etc/apache2/conf-enabled/security.conf && \
    sed -i 's/80/8080/g' /etc/apache2/ports.conf && \
    sed -i 's/443/8443/g' /etc/apache2/ports.conf && \
    rm /etc/apache2/sites-enabled/*


COPY conf/default-ssl.conf /etc/apache2/sites-enabled/
COPY --chown=$HTTPD_USER:$HTTPD_USER conf/database.php /var/www/html/app/Config/

EXPOSE 8080/tcp
EXPOSE 8443/tcp

USER www-data