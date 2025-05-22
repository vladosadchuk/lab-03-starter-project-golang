FROM golang:1.24-alpine AS builder

WORKDIR /app
COPY . .
RUN go mod download
RUN go build -o build

FROM gcr.io/distroless/static-debian12 AS runner

COPY --from=builder /app/build build
COPY --from=builder /app/templates templates

CMD ["./build", "serve"]
