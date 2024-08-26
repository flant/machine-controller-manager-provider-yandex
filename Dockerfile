# SPDX-FileCopyrightText: 2020 SAP SE or an SAP affiliate company and Gardener contributors
# SPDX-License-Identifier: Apache-2.0

#############      builder                                  #############
FROM golang:1.13.5@sha256:9da754b545f3c03e6e6fceeb86b091a97f55b1db12b6e1bef5b0e85582db1e31 AS builder

WORKDIR /go/src/github.com/flant/machine-controller-manager-provider-yandex
COPY . .

RUN .ci/build

#############      base                                     #############
FROM alpine:3.11.2@sha256:2171658620155679240babee0a7714f6509fae66898db422ad803b951257db78 as base

RUN apk add --update bash curl tzdata
WORKDIR /

#############      machine-controller               #############
FROM base AS machine-controller

COPY --from=builder /go/src/github.com/flant/machine-controller-manager-provider-yandex/bin/rel/machine-controller /machine-controller
ENTRYPOINT ["/machine-controller"]
