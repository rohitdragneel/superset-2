FROM apache/superset:5.0.0

USER root

RUN which python || true && \
    which python3 || true && \
    python --version || true && \
    python3 --version || true && \
    which pip && \
    pip --version

RUN pip install --no-cache-dir psycopg2-binary

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER superset

ENTRYPOINT ["/entrypoint.sh"]
