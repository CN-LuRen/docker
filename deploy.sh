#!/bin/bash

#使用说明，用来提示输入参数
usage() {
    echo "|-------------------------------------------|"
    echo "| usage: sh deploy.sh |mount|               |"
    echo "|-------------------------------------------|"
    echo "| mount |  mount config files to /docker    |"
    echo "|-------------------------------------------|"
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
        #挂载 prometheus 配置文件
    if test ! -f "/docker/prometheus/conf/prometheus.yaml" ;then
        mkdir -p /docker/prometheus/conf
        cp prometheus/prometheus.yaml /docker/prometheus/conf/prometheus.yaml
        echo "prometheus --> prometheus.yaml -> /docker"
    fi
}


#根据输入参数，选择执行对应方法，不输入则执行使用说明
case "$1" in
"mount")
    mount
;;
*)
    usage
;;
esac
