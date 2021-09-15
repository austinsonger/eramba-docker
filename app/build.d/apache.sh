#!/bin/bash
set -Eeuo pipefail

ln -sf /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/ && \
ln -sf /etc/apache2/mods-available/ssl.conf /etc/apache2/mods-enabled/ && \
ln -sf /etc/apache2/mods-available/ssl.load /etc/apache2/mods-enabled/ && \
ln -sf /etc/apache2/mods-available/setenvif.conf /etc/apache2/mods-enabled/ && \
ln -sf /etc/apache2/mods-available/setenvif.load /etc/apache2/mods-enabled/ && \
ln -sf /etc/apache2/mods-available/mime.conf /etc/apache2/mods-enabled/ && \
ln -sf /etc/apache2/mods-available/mime.load /etc/apache2/mods-enabled/ && \
ln -sf /etc/apache2/mods-available/socache_shmcb.load /etc/apache2/mods-enabled/ 