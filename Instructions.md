1. Follow the instructions in `eramba` folder
2. Follow the instructions in `db` folder
3. Build images with `docker-compose build`
4. Run services with `docker-compose up -d`
5. At first run, wait until MariaDB would have initialized its db schema (it may take a while)



docker rmi -f $(docker images -q)

docker system prune -a