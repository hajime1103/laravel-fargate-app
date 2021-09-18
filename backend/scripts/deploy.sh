#!/bin/bash
# deploy.sh の中で、「php artisan config:cache」を実行するようにします。
# なお、php コンテナ (app コンテナ) で使われているベースイメージ「php:8.0-fpm-buster」 の CMD は「["php-fpm"]」となっており、コンテナ起動時に PHP-FPM のプロセスが起動 するようになっています。そのため、上書き実行する deploy.sh でも PHP-FPM のプロセ スが起動するよう、最後に「php-fpm」を記述しています
set -eu
php artisan config:cache
php-fpm
