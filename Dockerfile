FROM php:8.2-fpm-alpine
LABEL MAINTENER="Jose Neto - jvnetobr@fedoraproject.org"

RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli