FROM node:18-alpine

RUN apk add --no-cache curl
RUN apk add --no-cache curl \
    && curl -fsSL 'https://github.com/pnpm/pnpm/releases/download/v6.16.1/pnpm-linuxstatic-x64' -o /bin/pnpm \
    && chmod +x /bin/pnpm

RUN apk --no-cache add git

ENV NODE_ENV=production
ARG NPM_BUILD="pnpm install"
EXPOSE 8080/tcp

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY ["package.json", "./"]
RUN $NPM_BUILD

COPY . .

ENTRYPOINT [ "node" ]
CMD ["src/index.js"]
