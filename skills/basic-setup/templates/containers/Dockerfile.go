# The build stage also runs the tests.
FROM golang:{{GOVERSION}} AS build
WORKDIR /src
COPY go.mod go.sum* ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -o /out/app .

FROM alpine:3.22
WORKDIR /app
COPY --from=build /out/app /usr/local/bin/app
COPY --from=build /src/assets ./assets
USER 1000:1000
CMD ["app"]
