FROM apache/superset:latest

USER root

# Install PostgreSQL driver and Google Sheets connector
RUN pip install psycopg2-binary "shillelagh[gsheetsapi]"

RUN mkdir -p /app/google

COPY service-account.json /app/google/service-account.json

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
