#syntax=docker/dockerfile:1.4

FROM mlocati/php-extension-installer:2 AS php_extension_installer_upstream

# The different stages of this Dockerfile are meant to be built into separate images
# https://docs.docker.com/develop/develop-images/multistage-build/#stop-at-a-specific-build-stage
# https://docs.docker.com/compose/compose-file/#target

# Base PHP image
FROM php:8.2.11-fpm-alpine AS php_base

WORKDIR /srv/app

# persistent / runtime deps
# hadolint ignore=DL3018
RUN apk add --no-cache \
		acl \
		fcgi \
		file \
		gettext \
		git \
        libqrencode \
        tesseract-ocr \
        ghostscript \
        imagemagick \
        poppler-utils \
        tiff \
        tiff-tools \
        psmisc \
        zbar \
	;

# php extensions installer: https://github.com/mlocati/docker-php-extension-installer
COPY --from=php_extension_installer_upstream --link /usr/bin/install-php-extensions /usr/local/bin/

RUN set -eux; \
    install-php-extensions \
		apcu \
		intl \
		opcache \
        mcrypt \
        gd \
        mysqli \
        pdo_mysql \
        ldap \
        imap \
        soap \
        ssh2 \
        apcu \
        intl \
        opcache \
        zip \
    ;

COPY --link ../php/conf.d/app.ini $PHP_INI_DIR/conf.d/

COPY --link ../php/php-fpm.d/zz-docker.conf /usr/local/etc/php-fpm.d/zz-docker.conf
RUN mkdir -p /var/run/php

COPY --link ../php/scripts/docker-healthcheck.sh /usr/local/bin/docker-healthcheck
RUN chmod +x /usr/local/bin/docker-healthcheck

COPY --link ../php/scripts/docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint

EXPOSE 9000
ENTRYPOINT ["docker-entrypoint"]

# Dev PHP image
FROM php_base AS php_dev

ENV APP_ENV=dev XDEBUG_MODE=off

RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

RUN set -eux; \
	install-php-extensions \
    	xdebug \
    ;

COPY --link ../php/conf.d/app.dev.ini $PHP_INI_DIR/conf.d/
