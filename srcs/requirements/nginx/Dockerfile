FROM alpine:3.15.5

RUN apk update

RUN apk upgrade

RUN apk add nginx

RUN apk add vim

RUN mkdir -p /etc/nginx/ssl

RUN apk add --update openssl && rm -rf /var/cache/apk/*

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=ael-khat.42.fr/UID=ael-khat"

RUN mkdir -p /var/run/nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["nginx", "-g", "daemon off;"]
