FROM ghcr.io/lampac-nextgen/lampac:latest

COPY init.conf .

USER root

# Устанавливаем cron и добавляем задание очистки кэша SISI каждые 5 минут
RUN apt-get update && \
    apt-get install -y cron && \
    echo "*/5 * * * * rm -rf /app/wwwroot/bookmarks/* /app/cache/*" | crontab - && \
    mkdir -p /var/run/cron

# Возвращаемся к пользователю app и запускаем cron вместе с Lampac
USER app
CMD bash -c "cron && ./Lampac"
