# Используем стабильный официальный образ Lampac
FROM docker.io/immisterio/lampac:latest

# Указываем порт, который будет слушать приложение
EXPOSE 9118

# Сообщаем системе, что приложение работает на порту 9118
ENV ASPNETCORE_URLS=http://+:9118

# Команда для запуска сервера
CMD ["dotnet", "Lampac.dll"]
