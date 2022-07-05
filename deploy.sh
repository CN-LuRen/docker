#!/bin/bash

#使用说明，用来提示输入参数
usage() {
    echo "| usage: sh deploy.sh mount stop update start up mirror"
    echo "| mount  |  mount config files to /docker"
    echo "| stop   |  stop all containers"
    echo "| update |  update all containers"
    echo "| start  |  start all containers"
    echo "| up     |  start all containers and exec command"
    echo "| mirror |  update mirrors"
    exit 1
}

#放置挂载文件
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

    if test ! -f "/docker/elk/es/" ;then
        mkdir -p /docker/elk/es
        echo "elk --> elasticsearch.yml -> /docker"
    fi

    if test ! -f "/docker/elk/kibana/" ;then
        mkdir -p /docker/elk/kibana
        echo "elk --> kibana.yml -> /docker"
    fi
    
    if test ! -f "/docker/elk/logstash/" ;then
        mkdir -p /docker/elk/logstash
        cp elk/logstash/logstash.conf /docker/elk/logstash/logstash.conf
        echo "elk --> logstash.conf -> /docker"
    fi
}

#停止容器
stop(){
    docker-compose stop
}

#启动容器
start(){
    docker-compose start
}

#更新镜像
update(){
    docker-compose stop
    docker-compose pull
    docker-compose up -d
}

#运行容器
up(){
    docker-compose up -d
}

#docker换源
mirror(){
    cp mirrors/daemon.json /etc/docker/daemon.json
    systemctl restart docker
}


#根据输入参数，选择执行对应方法，不输入则执行使用说明
case "$1" in
"mount")
    mount
;;
"stop")
    stop
;;
"update")
    update
;;
"start")
    start
;;
"up")
    up
;;
"mirror")
    mirror
;;
*)
    usage
;;
esac
