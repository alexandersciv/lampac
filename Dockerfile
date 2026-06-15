FROM ghcr.io/lampac-nextgen/lampac:latest

# Копируем ваш файл конфигурации
COPY init.conf .

# Устанавливаем cron и создаем задание для очистки кэша SISI
USER root
RUN apt-get update && apt-get install -y cron && \
    # Создаем задание: запускать скрипт очистки каждый час (можете изменить интервал)
    (echo "0 * * * * find /app/wwwroot/bookmarks/ -type f -atime +1 -delete 2>/dev/null || true") | crontab - && \
    (echo "0 * * * * find /app/cache/ -type f -atime +1 -delete 2>/dev/null || true") | crontab - && \
    # Запускаем cron и основной процесс
    echo "#!/bin/bash\ncron\n./Lampac" > /entrypoint.sh && chmod +x /entrypoint.sh

# Возвращаемся к обычному пользователю и задаем точку входа
USER app
EXPOSE 9118
ENTRYPOINT ["/entrypoint.sh"]
