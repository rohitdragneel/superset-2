#!/bin/sh
set -e

echo "========== PYTHON ENVIRONMENT =========="
echo "python:"
which python || true
python --version || true

echo "pip:"
which pip || true
pip --version || true

echo "sys.executable:"
python -c "import sys; print(sys.executable)" || true

echo "========== INSTALL psycopg2 =========="
pip install --no-cache-dir psycopg2-binary

echo "========== VERIFY psycopg2 =========="
python -c "import psycopg2; print('psycopg2:', psycopg2.__version__)" || true

echo "========== SUPERSET =========="
which superset || true
head -1 "$(which superset)" || true

echo "========== VENV =========="
ls -la /app || true
ls -la /app/.venv || true
ls -la /app/.venv/bin || true

echo "========== TEST VENV PYTHON =========="
/app/.venv/bin/python --version || true
/app/.venv/bin/python -c "import sys; print(sys.executable)" || true
/app/.venv/bin/python -c "import psycopg2; print(psycopg2.__version__)" || true

echo "========== SUPERSET START =========="

superset db upgrade

superset fab create-admin \
  --username admin \
  --firstname Admin \
  --lastname User \
  --email admin@example.com \
  --password admin123 || true

superset init

exec /usr/bin/run-server.sh
