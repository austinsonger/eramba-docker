FROM php:7.4-apache-buster

LABEL maintainer="Austin Songer" mail="austin@songer.pro"

ARG HTTPD_USER=www-data
ARG LATEST="https://downloadseramba.s3-eu-west-1.amazonaws.com/CommunityTGZ/latest.tgz"
ARG ERAMBA_DIR=eramba_community

WORKDIR /

# REQUIREMENTS
COPY build.d/requirements.sh /build.d/
RUN bash /build.d/requirements.sh

RUN curl ${LATEST} -o latest.tgz && \
    tar -zxvf /latest.tgz -C /var/www/html/ && \
    mv /var/www/html/${ERAMBA_DIR}/* /var/www/html/${ERAMBA_DIR}/.htaccess /var/www/html/ && \
    rm -r /var/www/html/${ERAMBA_DIR} /latest.tgz && \
    chown ${HTTPD_USER}:${HTTPD_USER} /var/www/html/* 
    
# CONFIGURE PHP.INI
COPY build.d/php.sh /build.d/
RUN bash /build.d/php.sh 

# ENABLE APACHE MODULES
COPY build.d/apache.sh /build.d/
RUN bash /build.d/apache.sh 

# SECURE APACHE
COPY build.d/secure.sh /build.d
RUN bash build.d/secure.sh

COPY conf/default-ssl.conf /etc/apache2/sites-enabled/
COPY --chown=$HTTPD_USER:$HTTPD_USER conf/database.php /var/www/html/app/Config/

EXPOSE 8080/tcp
EXPOSE 8443/tcp

USER www-data