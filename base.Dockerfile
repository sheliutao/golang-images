FROM golang:alpine3.13

LABEL maintainer="sheletao <sheletao@sina.cn>" version="1.0.0"

WORKDIR /app/

RUN set -ex \
 && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
 && apk update --no-cache \
 && apk add --no-cache git openssh \
 && cd /app \
 && go env -w GO111MODULE=on \
 && go env -w GOPROXY=https://goproxy.cn,direct
