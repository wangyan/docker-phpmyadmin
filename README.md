# DOCKER PHPMYADMIN

> nginx `1.x` + php7 + phpmyadmin `4.7.x`

## 一、创建 MySQL 容器

> 注意将`123456`换成你的MySQL Root密码

```shell
docker run --name mariadb \
-v /var/lib/mysql:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=123456 \
-p 3306:3306 \
-d mariadb:latest
```

支持的环境变量:

- MYSQL_ROOT_PASSWORD
- MYSQL_DATABASE
- MYSQL_USER
- MYSQL_PASSWORD
- MYSQL_ALLOW_EMPTY_PASSWORD 

更多信息：[https://github.com/docker-library/docs/tree/master/mysql](https://github.com/docker-library/docs/tree/master/mysql)

```shell
docker logs -f mysql //查看安装进度
```

## 二、创建 phpMyAdmin 容器

### 2.1 创建 phpMyAdmin 容器

> **温馨提示：**国内主机请将 `idiswy/phpmyadmin:latest` 换成 `daocloud.io/wangyan/phpmyadmin:latest`

```shell
docker run --name phpmyadmin \
--link mariadb:mysql \
-p 8080:80 \
-d idiswy/phpmyadmin:latest
```

### 2.2 快捷进入容器

首先，安装个小工具

```shell
curl --fail -L -O https://github.com/phusion/baseimage-docker/archive/master.tar.gz && \
tar xzf master.tar.gz && \
./baseimage-docker-master/install-tools.sh
```

然后，进入容器

```shell
docker-bash phpmyadmin
```

### 2.3 访问 phpmyadmin

<http://yourdomain:8080>