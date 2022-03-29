FROM golang:1.16 AS build
WORKDIR /echoserver

ENV GOPROXY=https://proxy.golang.org
COPY go.mod /echoserver/
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOFLAGS=-ldflags=-w go build -o /go/bin/echo-server -ldflags=-s -v github.com/shubhashreeb/echo-server

FROM scratch AS final
COPY --from=build /go/bin/echo-server /bin/echo-server
