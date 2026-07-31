#!/bin/sh
set -e
echo "Python:"
which python
python --version
echo "Installing psycopg2..."
pip install --no-cache-dir psycopg2-binary

echo "Verifying installation..."
python -c "import psycopg2; print(psycopg2.__version__)"

echo "Superset:"
which superset

echo "Pip:"
which pip

echo "Installed psycopg2:"
pip show psycopg2-binary || true

/app/.venv/bin/python -m pip show psycopg2-binary || true
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
