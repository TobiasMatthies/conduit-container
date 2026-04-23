FROM node:20

WORKDIR /app

COPY conduit-frontend/package.json conduit-frontend/package-lock.json* ./

RUN --mount=type=cache,target=/root/.npm npm install

COPY conduit-frontend/ .

EXPOSE 4200

CMD ["npm", "start", "--", "--host=0.0.0.0"]
