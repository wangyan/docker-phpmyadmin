FROM idiswy/lemp:latest
MAINTAINER WangYan <i@wangyan.org>

ENV PMA_SECRET          e24UHYQ67J^Dy6*J$cu!#Q3%q4BshWQCDJEqntspn&&3AvcuJfKZW46KC9WU9gNa
ENV PMA_USERNAME        pma
ENV PMA_PASSWORD        pwd123#PMA

RUN set -xe && \
    apt-get update && \
    apt-get install -y mysql-client && \

    export PMA_VERSION=$(curl -ks https://www.phpmyadmin.net/downloads/ | awk '/phpMyAdmin 4/{print $2}'| cut -d '<' -f 1 | head -1) && \
    curl -kO https://files.phpmyadmin.net/phpMyAdmin/${PMA_VERSION}/phpMyAdmin-${PMA_VERSION}-all-languages.tar.gz && \
    rm -rf /usr/share/nginx/html/* && \
    tar -zxf phpMyAdmin-${PMA_VERSION}-all-languages.tar.gz --strip-components 1 -C /usr/share/nginx/html && \
    rm -f phpMyAdmin-${PMA_VERSION}-all-languages.tar.gz && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./config.inc.php /usr/share/nginx/html/config.inc.php
COPY ./create_user.sql /usr/share/nginx/html/sql/create_user.sql
COPY ./entrypoint.sh /entrypoint.sh
COPY ./pma-firstrun.sh /pma-firstrun.sh

RUN chmod +x /entrypoint.sh /pma-firstrun.sh && \
    chown www-data:www-data /usr/share/nginx/html/ -R && \
    chmod 640 /usr/share/nginx/html/config.inc.php

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]

CMD ["phpmyadmin"]