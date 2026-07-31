FROM apache/superset:latest

USER root

# Install Google Sheets connector
RUN pip install "shillelagh[gsheetsapi]"

# Create credentials directory
RUN mkdir -p /app/google

COPY service-account.json /app/google/service-account.json

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
