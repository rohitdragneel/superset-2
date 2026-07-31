FROM apache/superset:latest
USER root

COPY entrypoint.sh /entrypoint.sh

COPY --chmod=755 entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
