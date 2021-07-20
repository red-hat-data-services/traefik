FROM registry.access.redhat.com/ubi8/go-toolset:latest as builder
USER root
ENV GOPATH=/go

# how can we have this without internet access? 🤔
RUN go get github.com/containous/go-bindata/...

WORKDIR /go/src/github.com/traefik/traefik
COPY . /go/src/github.com/traefik/traefik

RUN PATH="$PATH:/go/bin" go generate
RUN go test -v ./...
RUN go build -o dist/traefik ./cmd/traefik

# UBI-based final image
FROM registry.access.redhat.com/ubi8/ubi-micro:8.4
COPY --from=builder /go/src/github.com/traefik/traefik/dist/traefik /
EXPOSE 80
EXPOSE 8080
EXPOSE 8081
EXPOSE 8099
ENTRYPOINT ["/traefik"]
