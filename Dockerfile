FROM node:18-alpine

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

RUN npm install pnpm -g

WORKDIR /app

COPY ./package.json /app

COPY ./pnpm-lock.yaml /app

RUN pnpm install --production && rm -rf /root/.npm /root/.pnpm-store /usr/local/share/.cache /tmp/*

COPY . /app

RUN pnpm build

RUN chown -R appuser:appgroup /app

EXPOSE 8080

USER appuser

CMD [ "pnpm", "run", "prod" ]
