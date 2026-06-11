FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src
RUN git clone https://github.com/lampac-nextgen/lampac.git .
RUN dotnet publish "Lampac.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app
EXPOSE 9118
ENV ASPNETCORE_URLS=http://+:9118
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "Lampac.dll"]
