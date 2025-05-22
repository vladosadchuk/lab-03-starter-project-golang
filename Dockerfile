FROM golang:1.24-alpine AS builder

WORKDIR /app
COPY . .
RUN go mod download
RUN go build -o build

FROM scratch AS runner

COPY --from=builder /app/build build

CMD ["./build", "serve"]
