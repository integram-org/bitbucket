FROM golang:1.9 AS builder

RUN curl -fsSL -o /usr/local/bin/dep https://github.com/golang/dep/releases/download/v0.3.2/dep-linux-amd64 && chmod +x /usr/local/bin/dep
ENV PKG github.com/integram-org/bitbucket
WORKDIR /go/src/${PKG}

COPY Gopkg.toml Gopkg.lock ./

# install locked dependencies(including Integram framework) versions from Gopkg.lock
RUN dep ensure -vendor-only

COPY . ./

RUN go build -o /go/app ${PKG}/cmd

# move the builded binary into the tiny alpine linux image
FROM alpine:latest
RUN apk --no-cache add ca-certificates && rm -rf /var/cache/apk/*
WORKDIR /app

COPY --from=builder /go/app .
CMD ["./app"]