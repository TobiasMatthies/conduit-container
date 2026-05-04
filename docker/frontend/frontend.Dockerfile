FROM node:20

WORKDIR /app

COPY conduit-frontend/ .

RUN --mount=type=cache,target=/root/.npm npm install

EXPOSE 4200

CMD ["npm", "start", "--", "--host=0.0.0.0"]
