#!/bin/sh
set -e

bundle exec rake db:migrate

bundle exec rake webpacker:compile