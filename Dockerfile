FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR WepDockerApp

EXPOSE 80
EXPOSE 7442

#COPY PROJECT FILES
COPY ./*csproj ./
RUN dotnet restore

#COPY EVERYHING ELSE
COPY . .
RUN dotnet publish -c Release -o out

#Build image
FROM mcr.microsoft.com/dotnet/nightly/sdk:6.0
WORKDIR /WepDockerApp
COPY --from=build /WepDockerApp/out .
ENTRYPOINT ["dotnet","wDocker_App.dll"]