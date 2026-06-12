FROM docker.io/immisterio/lampac:latest
EXPOSE 9118
ENV ASPNETCORE_URLS=http://+:9118
