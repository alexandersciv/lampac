FROM ghcr.io/lampac-nextgen/lampac:latest

# Копируем конфиг
COPY init.conf .

# Устанавливаем cron и создаём задание
USER root
RUN apt-get update && apt-get install -y cron && \
    # Создаём задание: запускать каждые 5 минут
    (echo "*/5 * * * * find /app/wwwroot/bookmarks/ -type f -cmin +3 -delete 2>/dev/null || true") | crontab - && \
    (echo "*/5 * * * * find /app/cache/ -type f -cmin +3 -delete 2>/dev/null || true") | crontab - && \
    # Создаём entrypoint, который запускает cron и Lampac
    echo "#!/bin/bash\ncron\n./Lampac" > /entrypoint.sh && chmod +x /entrypoint.sh

USER app
EXPOSE 9118
ENTRYPOINT ["/entrypoint.sh"]
