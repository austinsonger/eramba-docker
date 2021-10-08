#!/bin/sh

cp /var/www/html/app/Config/database.php.default /var/www/html/app/Config/database.php
sed -i "s/'host' => '.*',/'host' => '$MYSQL_HOST',/" /var/www/html/app/Config/database.php
sed -i "s/'login' => '.*',/'login' => '$MYSQL_USER',/" /var/www/html/app/Config/database.php
sed -i "s/'password' => '.*',/'password' => '$MYSQL_PASSWORD',/" /var/www/html/app/Config/database.php
sed -i "s/'database' => '.*',/'database' => '$MYSQL_DATABASE',/" /var/www/html/app/Config/database.php

bash -c "/var/www/html/app/Console/cake cron job hourly"
bash -c "/var/www/html/app/Console/cake cron job daily"
bash -c "/var/www/html/app/Console/cake cron job yearly"

exec "$@"
