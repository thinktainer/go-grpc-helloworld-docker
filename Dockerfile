FROM golang:1.14-alpine3.11 AS build

LABEL maintainer "thinktainer <thinktainer@users.noreply.github.com>"
ENV GRPC_VERSION=1.27.1
ENV GO111MODULE=on

WORKDIR /root
RUN apk add --update --no-cache git

RUN go get google.golang.org/grpc/examples/helloworld/greeter_server@v${GRPC_VERSION} &&\
    go get google.golang.org/grpc/examples/helloworld/greeter_client@v${GRPC_VERSION}

FROM alpine:3.11

COPY --from=build /go/bin/greeter_server /bin/greeter_server
COPY --from=build /go/bin/greeter_client /bin/greeter_client
