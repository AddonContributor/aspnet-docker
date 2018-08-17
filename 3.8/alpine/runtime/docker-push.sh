#!/bin/bash
set -x
set -e
docker build . -t lohrer/aspnetcore-alpine:latest \
  && docker tag $(docker images --filter=reference='lohrer/aspnetcore-alpine:latest' -q) lohrer/aspnetcore-alpine:alpine3.8 \
  && docker tag $(docker images --filter=reference='lohrer/aspnetcore-alpine:latest' -q) lohrer/aspnetcore-alpine:runtime-deps-alpine3.8 \
  && docker push lohrer/aspnetcore-alpine:runtime-deps-alpine3.8 \
  && docker push lohrer/aspnetcore-alpine:alpine3.8 \
  && docker push lohrer/aspnetcore-alpine:latest