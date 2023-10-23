#syntax=docker/dockerfile:1.4

FROM httpd:alpine

COPY --link ../httpd/conf/httpd.conf /usr/local/apache2/conf/
COPY --link ../httpd/conf/extra/httpd-vhosts.conf /usr/local/apache2/conf/extra/
COPY --link ../httpd/conf/server.crt /usr/local/apache2/conf/
COPY --link ../httpd/conf/server.key /usr/local/apache2/conf/

EXPOSE 80
EXPOSE 443
