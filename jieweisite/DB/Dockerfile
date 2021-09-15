#制作mysql数据库镜像
FROM alpine:3.12.0
RUN apk add  mariadb mariadb-client --no-cache
#COPY --from=builderDB /var/lib/mysql /var/lib/mysql
#COPY --from=builderDB /etc/my.cnf.d/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
#COPY --from=builderDB /etc/my.cnf  /etc/my.cnf
COPY mysqlinit.txt /
COPY jingheproduct.sql /
COPY mysql.sh /
COPY mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY my.cnf /etc/my.cnf
RUN mysql_install_db  --user=root --datadir=/var/data/mysql

#innodb_force_recovery = 6
#innodb_purge_threads = 1
ENV rootpasswd 123456 
RUN mysqld_safe --datadir='/var/data/mysql' --user=root & sleep 30 \
   && echo -e "\nn\nY\n$rootpasswd\n$rootpasswd\nY\nn\nY\nY\n"  | mysql_secure_installation \
   && mysql -uroot -p$rootpasswd < mysqlinit.txt 
#   && sh /mysql.sh
#   && mysqladmin -uroot -p123456 shutdown 

CMD mysqld_safe --datadir='/var/data/mysql' --user=root  --log-error=/var/log/mariadb/mariadb.log \
    && tail -F /var/log/mariadb/mariadb.log 


