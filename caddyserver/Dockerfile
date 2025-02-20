FROM caddy:2.7.6-builder AS builder

WORKDIR /app
RUN XCADDY_GO_BUILD_FLAGS='-tags=memoize_builders' \
    xcaddy build \
    --output caddy \
    --with github.com/corazawaf/coraza-caddy/v2@latest

FROM caddy:2.7.6
COPY conf/* /etc/caddy/
COPY --from=builder /app/caddy /usr/bin/caddy
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile", "--watch"]