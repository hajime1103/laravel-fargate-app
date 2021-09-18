FROM node:16-alpine as node
FROM nginx:1.20-alpine
LABEL maintainer="ucan-lab <yes@u-can.pro>"
SHELL ["/bin/ash", "-oeux", "pipefail", "-c"]

ENV TZ=UTC

RUN apk update && \
  apk add --update --no-cache --virtual=.build-dependencies g++

# node command
COPY --from=node /usr/local/bin /usr/local/bin
# npm command
COPY --from=node /usr/local/lib /usr/local/lib
# yarn command
COPY --from=node /opt /opt

# Docker の nginx は 1.19 から、/etc/nginx/templates/に拡張子.template のファイルを配 置すると、コンテナ起動時に自動で envsubst による変換を行った上で拡張子.template を取 り除いて/etc/nginx/conf.d/に配置してくれるようになりました。docker-laravel の nginx は 1.20 であり、この機能が使えます。これにより、コンテナ起動時に環境変数 VPC_CIDR が渡されていれば、default.conf の「$VPC_CIDR」の部分には、環境変数の値が展開され るようになります
# nginx config file will be output to /etc/nginx/conf.d/ by envsubst
COPY ./infra/docker/nginx/default.conf /etc/nginx/templates/default.conf.template
COPY ./infra/docker/nginx/nginx.conf /etc/nginx/nginx.conf

COPY ./backend/public /work/backend/public

WORKDIR /work/backend
