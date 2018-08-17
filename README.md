# Asp.net core apps on alpine 3.8
This repository contains a dockerfile template that is built for a self-contained .Net Core application using alpine 3.8 as a base image.
Additionally it hardens the alpine image by removing things that could be used as an attack surface on os level.

# Credits
The ideas for hardening alpine were taken from https://gist.github.com/kost/017e95aa24f454f77a37