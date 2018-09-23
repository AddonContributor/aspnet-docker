# Intent

The docker images in this repository are intended for self-contained asp.net core 2.1 (or later) applications that are build with rid [alpine.3.7-x64 or alpine-x64](<https://docs.microsoft.com/en-us/dotnet/core/rid-catalog>) . This means the container does not contain a asp.net core runtime of any kind only the libraries that are needed by self-contained applications.

## Usage

This image can be used like this, adapt if required:

   FROM lohrer/aspnetcore-alpine:alpine3.8 as base

   COPY *.csproj ./
   COPY NuGet.config ./
   RUN dotnet restore -nowarn:nu1701 -r alpine.3.7-x64
   COPY . .
   RUN dotnet build -c Release -o /app -r alpine.3.7-x64 --no-restore

   FROM build AS publish
   RUN dotnet publish -c Release -o /app -r alpine.3.7-x64 --no-restore

   \# Define the port that is exposed by the application
   \# Port has to be greater than 1024 as only the root user can open these.
   \ <https://www.w3.org/Daemon/User/Installation/PrivilegedPorts.html>
   ENV PORT=8081
   \# Define the name of the application
   ENV EXE=/MyGreatApp
   Define the working directory inside the container
   ENV WD=/app

   ENV ASPNETCORE_URLS=http://+:${PORT} \
     \# Enable detection of running in a container
     DOTNET_RUNNING_IN_CONTAINER=true \
     DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false

   EXPOSE ${PORT}

   WORKDIR ${WD}
   COPY --from=publish ${WD} .

   \# Make build artifact an executable and delete the command that did this
   \# to ensure no other self-built application can run in this container.
   RUN chmod +x ${WD}${EXE} \
     && find $sysdirs -xdev \( \
        -name chmod -o \
        \) -delete

   USER appuser

   ENTRYPOINT ${WD}${EXE}

For more information about these images and their history, please see the Dockerfile. These images are updated via pull requests to the [AddonContributor/aspnet-docker GitHub repo](https://github.com/AddonContributor/aspnet-docker).

## Optimizing Container Size

Using package [Microsoft.Packaging.Tools.Trimming](https://www.nuget.org/packages/Microsoft.Packaging.Tools.Trimming/1.1.0-preview1-25818-0) together with the csproj-settings:

    <PropertyGroup>
        <TrimUnusedDependencies>true</TrimUnusedDependencies>
        <RootPackageReference>false</RootPackageReference>
        ...
   </PropertyGroup>

## Credits

The ideas for hardening alpine were taken from <https://gist.github.com/kost/017e95aa24f454f77a37>
