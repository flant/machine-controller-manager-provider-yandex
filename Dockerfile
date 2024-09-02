# SPDX-FileCopyrightText: 2020 SAP SE or an SAP affiliate company and Gardener contributors
# SPDX-License-Identifier: Apache-2.0

#############      builder                                  #############
FROM golang:1.23.0@sha256:613a108a4a4b1dfb6923305db791a19d088f77632317cfc3446825c54fb862cd AS builder

WORKDIR /go/src/github.com/flant/machine-controller-manager-provider-yandex
COPY . .

RUN .ci/build

#############      base                                     #############
FROM alpine:3.11.2 as base

RUN apk add --update bash curl tzdata
WORKDIR /

#############      machine-controller               #############
FROM base AS machine-controller

COPY --from=builder /go/src/github.com/flant/machine-controller-manager-provider-yandex/bin/rel/machine-controller /machine-controller
ENTRYPOINT ["/machine-controller"]
