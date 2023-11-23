### PHP BLOCK

NGINX_DEFAULT_RUN_USER=nginx
NGINX_SBS_INCLUDES_LOCATIONS_CONF_FILE=$NGINX_SBS_INCLUDES_DIR/default-locations.conf
NGINX_SBS_INCLUDES_LOCATIONS_PHP_CONF_FILE=$NGINX_SBS_INCLUDES_DIR/default-locations-php.conf
PHP_CONF_DIR=/etc/$PHP_VERSION
PHP_FPM_CONF_FILE=$PHP_CONF_DIR/php-fpm.d/www.conf
PHP_INI_CONF_FILE=$PHP_CONF_DIR/conf.d/custom.ini
PHP_SESSIONS_PATH=/tmp/phpsessions
PHP_UPLOAD_TMP_DIR=/tmp/phptmp
SUPERVISORD_CONF_FILE=/etc/supervisord.conf
EXIM_CONF_FILE=/etc/exim/exim.conf
ENV_VARS=$(awk 'BEGIN{for(v in ENVIRON) print "$"v}')

echo -e "Adaptando arquivos de configuracao do Nginx para PHP...\n" && \
  sed -i "s/\(^index\)\(.*$\)/\1 index.php \2/g" $NGINX_SB_DEFAULT_CONF_FILE && \
  sed -i "s;=404;/index.php?\$args;" $NGINX_SBS_INCLUDES_LOCATIONS_CONF_FILE

echo -e "Criando diretorio(s) default do PHP...\n" && \
  mkdir -p $PHP_SESSIONS_PATH $PHP_UPLOAD_TMP_DIR && \
  echo -e "Atribuindo permissoes no(s) diretorio(s) default do PHP...\n" && \
  chown -R $NGINX_DEFAULT_RUN_USER $PHP_SESSIONS_PATH $PHP_UPLOAD_TMP_DIR
