#!/bin/bash

#使用说明，用来提示输入参数
usage() {
    echo "|-------------------------------------------------------------------------------|"
    echo "| usage: sh deploy.sh |mount|start|stop|rm|mysql|redis|nacos|nginx|seata|minio| |"
    echo "|-------------------------------------------------------------------------------|"
    echo "| mount |  mount config files to /docker                                        |"
    echo "| start |  start all docker containers                                          |"
    echo "| stop  |  stop all docker containers                                           |"
    echo "| rm    |  remove all docker containers                                         |"
    echo "| mysql |  start mysql docker container                                         |"
    echo "| redis |  start redis docker container                                         |"
    echo "| nacos |  start nacos docker container                                         |"
    echo "| nginx |  start nginx docker container                                         |"
    echo "| seata |  start seata docker container                                         |"
    echo "| minio |  start minio docker container                                         |"
    echo "|-------------------------------------------------------------------------------|"
    exit 1
}

##放置挂载文件
mount(){
    #挂载 nginx 配置文件
    if test ! -f "/docker/nginx/conf/nginx.conf" ;then
        mkdir -p /docker/nginx/conf
        cp nginx/nginx.conf /docker/nginx/conf/nginx.conf
        echo "nginx --> nginx.conf -> /docker"
    fi
    #挂载 redis 配置文件
    if test ! -f "/docker/redis/conf/redis.conf" ;then
        mkdir -p /docker/redis/conf
        cp redis/redis.conf /docker/redis/conf/redis.conf
        echo "redis --> redis.conf -> /docker"
    fi
    #挂载 nacos 配置文件
    if test ! -f "/docker/nacos/conf/custom.properties" ;then
        mkdir -p /docker/nacos/conf
        cp nacos/custom.properties /docker/nacos/conf/custom.properties
        echo "nacos --> custom.properties -> /docker"
    fi
    #挂载 seata 配置文件
    if test ! -f "/docker/seata/conf/registry.conf" ;then
        mkdir -p /docker/seata/conf
        cp seata/registry.conf /docker/seata/conf/registry.conf
        echo "seate --> registry.conf -> /docker"
    fi
}

#启动基础模块
start(){
    docker-compose up -d mysql nacos seata-server nginx-web redis minio
    echo "Start All"
}

#启动mysql
mysql(){
    docker-compose up -d mysql
    echo "Start Mysql"
}

#启动redis
redis(){
    docker-compose up -d redis
    echo "Start Redis"
}

#启动nacos
nacos(){
    docker-compose up -d nacos
    echo "Start Nacos"
}

#启动seata
seata(){
    docker-compose up -d seata-server
    echo "Start Seata"
}

#启动minio
minio(){
    docker-compose up -d minio
    echo "Start Minio"
}

#启动基础模块
nginx(){
    docker-compose up -d nginx-web
    echo "Start Nginx"
}


#关闭所有模块
stop(){
    docker-compose stop
    echo "Stop All"
}

#删除所有模块
rm(){
    docker-compose rm
    echo "Remove All"
}

#根据输入参数，选择执行对应方法，不输入则执行使用说明
case "$1" in
"mount")
    mount
;;
"start")
    start
;;
"stop")
    stop
;;
"rm")
    rm
;;
"mysql")
    mysql
;;
"redis")
    redis
;;
"nacos")
    nacos
;;
"nginx")
    nginx
;;
"minio")
    minio
;;
"seata")
    seata
;;
*)
    usage
;;
esac
