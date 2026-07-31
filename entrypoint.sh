#!/bin/sh
set -e

superset db upgrade

superset fab create-admin \
  --username admin \
  --firstname Admin \
  --lastname User \
  --email admin@example.com \
  --password admin123 || true

superset init

exec /usr/bin/run-server.sh