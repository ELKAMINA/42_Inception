FROM alpine:3.15.5

LABEL maintainer="Amina ELK"

RUN apk update

RUN apk upgrade

RUN apk add openrc

RUN apk add vim

RUN apk add --no-cache mariadb mariadb-client mariadb-common \
	&& rm -f /var/cache/apk/*
#pwgen is a password generator

COPY ./conf/my.cnf /etc/my.cnf

COPY ./tools/script.sh /scripts/script.sh

RUN chmod -R 755 /scripts
#RUN chmod 700 ./tools/script.sh
#RUN mkdir -p /var/lib/mysql

#RUN mkdir -p /var/lib/mysql/mysql.sock

#COPY conf/mariadb-server.conf /etc/my.cnf.d/mariadb-server.cnf

#EXPOSE 3306

#VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["./scripts/script.sh"]
