FROM --platform=linux/amd64 sweagent/swe-agent-run:latest

COPY ./scripts/entrypoint.sh /app/entrypoint.sh

RUN chmod +x /app/entrypoint.sh
WORKDIR /app

ENTRYPOINT ["./entrypoint.sh"]
