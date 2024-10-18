
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base


WORKDIR /app


FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build


COPY . /src


WORKDIR /src


RUN ls
RUN dotnet restore
RUN dotnet build "./10_Calculator.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "./10_Calculator.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish ./

# Определяем команду запуска контейнера
ENTRYPOINT ["dotnet", "10_Calculator.dll"]
