# Asp.net core apps on alpine 3.8
This repository contains a dockerfile template that is built for a self-contained .Net Core application using alpine 3.8 as a base image.
Additionally it hardens the alpine image by removing things that could be used as an attack surface on os level.

# Instructions:
 
 Configure Kestrel web server to bind to port 8081 when present

 ENV ASPNETCORE_URLS=http://+:8081 \
   # Enable detection of running in a container
   DOTNET_RUNNING_IN_CONTAINER=true \
   # Set the invariant mode since icu_libs isn't included (see https://github.com/dotnet/announcements/issues/20)
   DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=true

 EXPOSE 8081
 WORKDIR /app
 COPY --from=publish /app .

 Make freshly built binary executable by user `appuser` and delete the chmod command afterwards.
 RUN chmod +x /app/mygreatapp \
    && find $sysdirs -xdev \( \
       -name chmod -o \
        \) -delete \

 USER appuser

 ENTRYPOINT $EXE

# Credits
The ideas for hardening alpine were taken from https://gist.github.com/kost/017e95aa24f454f77a37