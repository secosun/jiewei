FROM docker.io/library/centos:centos8
COPY centos8php.sh /opt/script/
COPY compose.pwd /opt/script/
RUN  sh /opt/script/centos8php.sh
#RUN  composer create-project Vardot/varbase-project:~9 varbase5 --no-dev --no-interaction -vvv
#由于网络速度原因，上述安装命令很可能失败，下面命令将会从github上下载提前安装好的版本
RUN  passwordcompose=$(cat /opt/script/compose.pwd) \
     && sh -c "composer config --global --auth github-oauth.github.com  $passwordcompose" \
     && composer config -g process-timeout 7200
WORKDIR /opt/varbase90
#RUN git clone git@github.com:secosun/varbase90dev.git
RUN git clone https://github.com/secosun/varbase90dev.git
RUN mkdir -p /usr/share/nginx/html \
    && cp -rf varbase90dev/* /usr/share/nginx/html
RUN PHP_FPM_LISTEN_PORT="0.0.0.0:9000" \
    && sed -i "s|listen\s*=\s*/run/php-fpm/www.sock|listen = ${PHP_FPM_LISTEN_PORT}|g" /etc/php-fpm.d/www.conf 

RUN PHP_FPM_ALLOWED_CLIENTS="127.0.0.1" \
    && sed -i "s|listen.allowed_clients\s*=\s*127.0.0.1|;listen.allowed_clients = ${PHP_FPM_ALLOWED_CLIENTS}|g" /etc/php-fpm.d/www.conf

RUN PHP_MAX_EXECUTION_TIME="7200" \
    && sed -i "s|max_execution_time\s*=\s*30|max_execution_time = ${PHP_MAX_EXECUTION_TIME}|g" /etc/php.ini

RUN PHP_MEMORY_LIMIT="1024M" \
    && sed -i "s|memory_limit\s*=\s*128M|memory_limit = ${PHP_MEMORY_LIMIT}|g" /etc/php.ini

WORKDIR /usr/share/nginx/html/
RUN dnf install net-tools -y
#ps aux | grep php-fpm
# kill -USR2  195968
# kill -USR2 $(cat /run/php-fpm/php-fpm.pid)
CMD mkdir -p /run/php-fpm/ \
    && php-fpm \
    && netstat -atunlp \
    && tail -F /var/log/php-fpm/www-error.log
    