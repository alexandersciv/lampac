FROM ghcr.io/lampac-nextgen/lampac:latest

COPY init.conf .

USER root

# Устанавливаем cron и создаём задание очистки
RUN apt-get update && \
    apt-get install -y cron && \
    echo "*/5 * * * * rm -rf /app/wwwroot/bookmarks/* /app/cache/*" | crontab - && \
    mkdir -p /var/run/cron

# Возвращаемся к пользователю app и запускаем cron + Lampac
USER app
CMD bash -c "cron && ./Lampac"
