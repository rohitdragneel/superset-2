#!/bin/sh
set -e

python --version
which python
python -c "import psycopg2; print(psycopg2.__version__)"

superset db upgrade

superset fab create-admin \
  --username admin \
  --firstname Admin \
  --lastname User \
  --email admin@example.com \
  --password admin123 || true

superset init

exec /usr/bin/run-server.sh
