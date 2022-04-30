#!/bin/bash

#使用说明，用来提示输入参数
usage() {
    echo "Usage: sh 执行脚本.sh [|mount|base|stopall|rm|rmiNoneTag]"
    exit 1
}

##放置挂载文件
mount(){
    #挂载 nginx 配置文件
    if test ! -f "/docker/nginx/conf/nginx.conf" ;then
        mkdir -p /docker/nginx/conf
        cp nginx/nginx.conf /docker/nginx/conf/nginx.conf
    fi
    #挂载 redis 配置文件
    if test ! -f "/docker/redis/conf/redis.conf" ;then
        mkdir -p /docker/redis/conf
        cp redis/redis.conf /docker/redis/conf/redis.conf
    fi
    #挂载 nacos 配置文件
    if test ! -f "/docker/nacos/conf/custom.properties" ;then
        mkdir -p /docker/nacos/conf
        cp nacos/custom.properties /docker/nacos/conf/custom.properties
    fi
    #挂载 seata 配置文件
    if test ! -f "/docker/seata/conf/registry.conf" ;then
        mkdir -p /docker/seata/conf
        cp seata/registry.conf /docker/seata/conf/registry.conf
    fi
}

#启动基础模块
base(){
    docker-compose up -d mysql nacos seata-server nginx-web redis minio
}

#关闭所有模块
stopall(){
    docker-compose stop
}

#删除所有模块
rm(){
    docker-compose rm
}

#删除Tag为空的镜像
rmiNoneTag(){
    docker images|grep none|awk '{print $3}'|xargs docker rmi -f
}

#根据输入参数，选择执行对应方法，不输入则执行使用说明
case "$1" in
"mount")
    mount
;;
"base")
    base
;;
"stopall")
    stopall
;;
"rm")
    rm
;;
"rmiNoneTag")
    rmiNoneTag
;;
*)
    usage
;;
esac
