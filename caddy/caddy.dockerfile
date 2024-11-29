FROM caddy:2.7.6-alpine

COPY Caddyfile /etc/caddy/Caddyfile

RUN mkdir -p /var/www/html
RUN cp /usr/share/caddy/* /var/www/html