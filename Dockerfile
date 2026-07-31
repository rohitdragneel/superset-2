FROM apache/superset:latest

USER root

RUN pip install --no-cache-dir psycopg2-binary "shillelagh[gsheetsapi]" && \
    python -c "import psycopg2; print('psycopg2:', psycopg2.__version__)"

RUN mkdir -p /app/google
COPY service-account.json /app/google/service-account.json

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
