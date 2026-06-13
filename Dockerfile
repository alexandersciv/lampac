FROM ghcr.io/lampac-nextgen/lampac:latest
COPY init.conf .
EXPOSE 9118
ENV ASPNETCORE_URLS=http://+:9118
