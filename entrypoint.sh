#!/bin/sh
set -e

echo "========== ENVIRONMENT =========="
echo "Python:"
which python || true
python --version || true

echo "Pip:"
which pip || true
pip --version || true

echo "Superset:"
which superset || true

echo "========== INSTALLING psycopg2 =========="
pip install --no-cache-dir psycopg2-binary

echo "========== VERIFY SYSTEM PYTHON =========="
python -c "import psycopg2; print('psycopg2:', psycopg2.__version__)" || true

echo "========== VERIFY SUPERSET PYTHON =========="
if [ -f /app/.venv/bin/python ]; then
    echo "Using /app/.venv/bin/python"
    /app/.venv/bin/python --version || true

    # Install into the venv if pip exists
    if /app/.venv/bin/python -m pip --version >/dev/null 2>&1; then
        /app/.venv/bin/python -m pip install --no-cache-dir psycopg2-binary || true
        /app/.venv/bin/python -c "import psycopg2; print('venv psycopg2:', psycopg2.__version__)" || true
    else
        echo "pip not available inside /app/.venv"
    fi
fi

echo "========== INITIALIZING SUPERSET =========="

superset db upgrade

superset fab create-admin \
  --username admin \
  --firstname Admin \
  --lastname User \
  --email admin@example.com \
  --password admin123 || true

superset init

echo "========== STARTING SUPERSET =========="

exec /usr/bin/run-server.sh
