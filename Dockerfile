FROM node:lts-alpine

RUN npm install pnpm -g

WORKDIR /app

COPY ./package.json /app

COPY ./pnpm-lock.yaml /app

RUN pnpm install

COPY . /app

RUN pnpm build

EXPOSE 8080

CMD ["sh", "-c", "pnpm run prod"]
