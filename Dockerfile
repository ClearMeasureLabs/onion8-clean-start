FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
EXPOSE 8080 80
WORKDIR /app
COPY /built/ /app

RUN ls -lsa /app

RUN mkdir /sqlcmd
RUN apt-get update
RUN apt-get install -y curl

RUN curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list |  tee /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update
RUN apt-get install mssql-tools18 unixodbc-dev


USER $APP_UID
ENTRYPOINT ["dotnet", "ProgrammingWithPalermo.ChurchBulletin.UI.Server.dll"]