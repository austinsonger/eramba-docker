docker exec -i Eramba bash -c '/var/www/html/eramba_community/app/Console/cake cron job yearly'
docker exec -i Eramba bash -c 'chown -R apache:apache /var/www/html/eramba_community'
docker exec -i Eramba bash -c 'chmod 777 -R /var/www/html/eramba_community/cron'
