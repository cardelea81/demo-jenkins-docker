FROM debian:jessie

COPY tools/main /app/main
CMD ["/app/main"]