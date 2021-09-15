dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
dnf -y install https://rpms.remirepo.net/enterprise/remi-release-8.rpm
dnf -y install 'dnf-command(upgrade)'
dnf -y install dnf-utils
dnf -y module reset php
dnf -y module install php:remi-7.4
dnf -y install php-gd
php -v
php --modules
dnf -y install patch
patch -v
php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/local/bin/composer
composer config -g repos.packagist composer https://mirrors.aliyun.com/composer/
dnf -y install zip unzip
dnf -y install php-pdo
dnf -y install php-mysqlnd
dnf -y install git