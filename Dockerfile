FROM apache/superset:5.0.0

USER root

RUN /app/.venv/bin/pip install --no-cache-dir psycopg2-binary

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER superset

ENTRYPOINT ["/entrypoint.sh"]
