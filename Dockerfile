FROM alpine:latest
LABEL MAINTENER="Jose Neto - jvnetobr@fedoraproject.org"

ENV \
  PHP_MAX_EXEC_TIME=60 \
  PHP_MAX_POST_SIZE=50M \
  PHP_MEM_LIMIT=128M \
  PHP_SHORT_OPENTAG=on \
  PHP_FPM_STATUS_LISTEN=127.0.0.1:9001 \
  PHP_UPLOAD_MAX_FILESIZE=50M

ARG PHP_PKG_NAME=php82

RUN \
  apk add -q --no-cache \
    fcgi \
    gettext \
    $PHP_PKG_NAME-bcmath \
    $PHP_PKG_NAME-common \
    $PHP_PKG_NAME-ctype \
    $PHP_PKG_NAME-curl \
    $PHP_PKG_NAME-dom \
    $PHP_PKG_NAME-exif \
    $PHP_PKG_NAME-fileinfo \
    $PHP_PKG_NAME-fpm \
    $PHP_PKG_NAME-ftp \
    $PHP_PKG_NAME-gd \
    $PHP_PKG_NAME-gettext \
    $PHP_PKG_NAME-iconv \
    $PHP_PKG_NAME-intl \
    $PHP_PKG_NAME-json \
    $PHP_PKG_NAME-ldap \
    $PHP_PKG_NAME-mbstring \
    $PHP_PKG_NAME-mysqli \
    $PHP_PKG_NAME-opcache \
    $PHP_PKG_NAME-openssl \
    $PHP_PKG_NAME-pecl-imagick \
    $PHP_PKG_NAME-phar \
    $PHP_PKG_NAME-session \
    $PHP_PKG_NAME-simplexml \
    $PHP_PKG_NAME-tokenizer \
    $PHP_PKG_NAME-xml \
    $PHP_PKG_NAME-xmlreader \
    $PHP_PKG_NAME-xmlwriter \
    $PHP_PKG_NAME-zip \
    $PHP_PKG_NAME-zlib \
    moreutils \
    tzdata

RUN \
  ln -s /usr/sbin/php-fpm* /usr/sbin/php-fpm && \
  ln -s /usr/bin/php* /usr/bin/php

ENV PHP_PKG_NAME=$PHP_PKG_NAME
WORKDIR /var/www/html
EXPOSE 9000/tcp
CMD ["php-fpm"]
HEALTHCHECK --interval=15s --timeout=5s --retries=3 CMD cgi-fcgi -bind -connect $PHP_FPM_STATUS_LISTEN