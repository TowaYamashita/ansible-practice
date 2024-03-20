#!/bin/bash
amazon-linux-extras enable nginx1 php7.4 && \
    amazon-linux-extras install -y nginx1 php7.4 epel && \
    yum install -y php-xml unzip

curl -sO https://getcomposer.org/download/2.1.0/composer.phar && \
    mv composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer

mkdir -p /var/www/service && \
    ln -s /var/www/service /usr/share/nginx/html/service

cat - << 'EOS' > /var/www/service/index.php
<?php
phpinfo();
EOS

cat - << 'EOS' > /etc/nginx/default.d/php.conf
location ~* \.php$ {
    try_files $uri =404;

    fastcgi_split_path_info ^(.+\.php)(/.+)$;
    include fastcgi_params;

    fastcgi_index  index.php;
    fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
    fastcgi_intercept_errors on;
    fastcgi_pass   unix:/run/php-fpm/www.sock;
}
EOS

service nginx start