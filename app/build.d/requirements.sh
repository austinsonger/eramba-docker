#!/bin/bash
set -Eeuo pipefail

apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -yq install \
    wkhtmltopdf \
    libzip-dev \
    libbz2-ocaml-dev \
    libpng-dev \
    libldap2-dev \
    libicu-dev \
    libfreetype6-dev \
    libjpeg-dev \
    libcurl4 \
    libcurl4-gnutls-dev \
    libxml2-dev \
    libssl-dev \
    python2 \
    wget \
    libonig-dev && \
    # Required PHP extensions
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install -j$(nproc) zip bz2 gd exif ldap intl pdo_mysql json mbstring curl simplexml session fileinfo phar