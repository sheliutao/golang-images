FROM go-base:v1 AS builder

LABEL maintainer="sheletao <sheletao@sina.cn>" version="1.0.0"
LABEL stage=gobuilder

ENV CGO_ENABLED=0 \
    GOOS=linux \
    GOPROXY=https://goproxy.cn,direct \
    SERVICE=test

WORKDIR /app/

COPY . /app
RUN set -ex \
 && go mod tidy
# 可自行进行go build压缩成二进制文件运行

FROM alpine

RUN set -ex \
 && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
 && apk update --no-cache \
 && apk add --no-cache ca-certificates tzdata
ENV TZ Asia/Shanghai

WORKDIR /app
COPY --from=builder /app /app

CMD ["go run test.go"]
