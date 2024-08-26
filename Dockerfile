# SPDX-FileCopyrightText: 2020 SAP SE or an SAP affiliate company and Gardener contributors
# SPDX-License-Identifier: Apache-2.0

#############      builder                                  #############
FROM golang:1.13.5 AS builder

WORKDIR /go/src/github.com/flant/machine-controller-manager-provider-yandex
COPY . .

RUN .ci/build

#############      base                                     #############
FROM alpine:3.20.2@sha256:0a4eaa0eecf5f8c050e5bba433f58c052be7587ee8af3e8b3910ef9ab5fbe9f5 as base

RUN apk add --update bash curl tzdata
WORKDIR /

#############      machine-controller               #############
FROM base AS machine-controller

COPY --from=builder /go/src/github.com/flant/machine-controller-manager-provider-yandex/bin/rel/machine-controller /machine-controller
ENTRYPOINT ["/machine-controller"]
