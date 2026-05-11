ARG NODE_VERSION=20-alpine
ARG NGINX_VERSION=alpine3.22

FROM node:${NODE_VERSION} AS builder

WORKDIR /app

COPY conduit-frontend/ .

RUN --mount=type=cache,target=/root/.npm npm ci

RUN npm run build

FROM nginxinc/nginx-unprivileged:${NGINX_VERSION} AS runner

RUN rm /etc/nginx/conf.d/default.conf

COPY nginx.conf /etc/nginx/nginx.conf

COPY --chown=nginx:nginx --from=builder /app/dist/angular-conduit/ /usr/share/nginx/html/

USER nginx

EXPOSE 8080

ENTRYPOINT ["nginx", "-c", "/etc/nginx/nginx.conf"]
CMD ["-g", "daemon off;"]
