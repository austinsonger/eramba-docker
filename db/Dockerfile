FROM mariadb:10.4

ARG LATEST="https://downloadseramba.s3-eu-west-1.amazonaws.com/CommunityTGZ/latest.tgz"
ARG ERAMBA_DIR=eramba_community

RUN sed -i '/^#sql_mode.* /s/.*/sql_mode=/' /etc/mysql/my.cnf && \
    sed -i '/^#max_allowed_packet /s/^;//' /etc/mysql/my.cnf && \
    sed -i 's/^\(max_allowed_packet\s*=\s*\).*$/\1128M/' /etc/mysql/my.cnf && \
    sed -i '/^\[mysqld\]/a innodb_lock_wait_timeout=200' /etc/mysql/my.cnf && \
    apt update && \
    DEBIAN_FRONTEND=noninteractive apt-get -yq install curl &&\
    mkdir /tmp_src && \
    curl -o latest.tgz ${LATEST} && \
    tar zxvf /latest.tgz -C /tmp_src && \
    cp /tmp_src/${ERAMBA_DIR}/app/Config/db_schema/c*.sql /docker-entrypoint-initdb.d && \
    rm -r /tmp_src /latest.tgz