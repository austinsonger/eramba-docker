![](https://miro.medium.com/max/710/0*rQpagILnBH4__4Fb.png)

1. Build images with `docker-compose build`
2. Run services with `docker-compose up -d`
3. Open Browser https://localhost/

### default-ssl.conf

- This is currently using `localhost` self-generated certs.
- You can generated your own self-generated certs


<!--
------------------------------
#####  Current - localhost

```
SSLCertificateFile	/certs/localhost.cert
SSLCertificateKeyFile /certs/localhost.key
```


#### FOR CLEANUP

```
docker system prune -a
```
-->
