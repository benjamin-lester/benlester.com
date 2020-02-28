FROM mcr.microsoft.com/dotnet/core/aspnet:2.2 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build
WORKDIR /src
COPY ["benlester.com.csproj", "./"]
RUN dotnet restore "./benlester.com.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "benlester.com.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "benlester.com.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "benlester.com.dll"]
