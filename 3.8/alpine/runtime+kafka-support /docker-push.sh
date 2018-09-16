#!/bin/bash
set -ex
docker build . -t lohrer/aspnetcore-alpine-kafka:latest \
  && docker tag $(docker images --filter=reference='lohrer/aspnetcore-alpine:latest' -q) lohrer/aspnetcore-alpine-kafka:alpine3.8 \
  && docker tag $(docker images --filter=reference='lohrer/aspnetcore-alpine:latest' -q) lohrer/aspnetcore-alpine-kafka:runtime-alpine3.8 \
  && docker push lohrer/aspnetcore-alpine-kafka:runtime-alpine3.8 \
  && docker push lohrer/aspnetcore-alpine-kafka:alpine3.8 \
  && docker push lohrer/aspnetcore-alpine-kafka:latest