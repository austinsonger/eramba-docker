#!/bin/bash

sed -i 's/^\(ServerTokens\s*\).*$/\1Prod/' /etc/apache2/conf-enabled/security.conf && \
sed -i 's/^\(ServerSignature\s*\).*$/\1Off/' /etc/apache2/conf-enabled/security.conf && \
sed -i 's/^\(TraceEnable\s*\).*$/\1Off/' /etc/apache2/conf-enabled/security.conf && \
sed -i 's/80/8080/g' /etc/apache2/ports.conf && \
sed -i 's/443/8443/g' /etc/apache2/ports.conf && \
rm /etc/apache2/sites-enabled/*