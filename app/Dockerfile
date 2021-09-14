FROM ubuntu:20.04

LABEL maintainer="Austin Songer" mail="austin@songer.pro"

ARG HTTPD_USER=www-data
ARG LATEST="https://downloadseramba.s3-eu-west-1.amazonaws.com/CommunityTGZ/latest.tgz"
ARG ERAMBA_DIR=eramba_community
WORKDIR /

# sudo apt install php7.4-{common,cli,gd,intl,json,mbstring,zip,exif,ldap,curl,readline,xml,bz2,simplexml}

# wkhtmltopdf 
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -yq install && apt install -y php7.4 \
        libzip-dev libbz2-ocaml-dev libpng-dev \ 
        libldap2-dev libicu-dev libfreetype6-dev libjpeg-dev \
        php-common php-cli php-gd php-intl php-json php-mbstring \
        php-zip php-exif php-ldap php-curl php-readline php-xml php-bz2 php-simplexml 

RUN curl -o eramba_latest.tgz ${LATEST} && \
    tar zxvf /eramba_latest.tgz -C /var/www/html/ && \
    mv /var/www/html/${ERAMBA_DIR}/* /var/www/html/${ERAMBA_DIR}/.htaccess /var/www/html/ && \
    rm -r /var/www/html/${ERAMBA_DIR} /eramba_latest.tgz && \
    chown ${HTTPD_USER}:${HTTPD_USER} /var/www/html/*

# CONFIGURE PHP.INI
RUN bash /scripts/php.sh

# ENABLE APACHE2 MODULES
RUN bash /scripts/apache.sh 

# SECURING APACHE
RUN bash /scripts/secure.sh 

EXPOSE 8080/tcp
EXPOSE 8443/tcp

USER www-data