FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Клонируем исходный код Lampac
RUN git clone https://github.com/lampac-nextgen/lampac.git .
RUN dotnet publish "Lampac.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app

# Копируем скомпилированные файлы
COPY --from=build /app/publish .

EXPOSE 9118
ENV ASPNETCORE_URLS=http://+:9118

# Точка входа
ENTRYPOINT ["dotnet", "Lampac.dll"]
