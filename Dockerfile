FROM apache/superset:4.1.2

USER root

RUN pip install --no-cache-dir \
    psycopg2-binary \
    "shillelagh[gsheetsapi]"

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER superset

ENTRYPOINT ["/entrypoint.sh"]
