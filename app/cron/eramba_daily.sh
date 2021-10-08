docker exec -i Eramba bash -c '/var/www/html/app/Console/cake cron job daily'
docker exec -i Eramba bash -c 'chown -R www-data:www-data /var/www/html/'
docker exec -i Eramba bash -c 'chmod 777 -R /var/www/html/app/'
