FROM apache/superset:5.0.0

USER root

# Install PostgreSQL driver
RUN pip install --no-cache-dir psycopg2-binary

# Install Google Sheets support
RUN pip install --no-cache-dir "shillelagh[gsheetsapi]"

# Create directory for Google service account
RUN mkdir -p /app/google

# Copy Google service account
COPY service-account.json /app/google/service-account.json

# Copy entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER superset

ENTRYPOINT ["/entrypoint.sh"]
