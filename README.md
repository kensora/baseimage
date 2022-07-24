# baseimage

## Scripts

### Build

Build all available base images, for example: `make build OS_VERSION=focal`
You can set the following environment variables:

| name       | default | description                                                  |
| ---------- | ------- | ------------------------------------------------------------ |
| APP_USER   | app     | The user under which the process will run                    |
| APP_PORT   |         | Port whitch your application uses. Needed for proxy by Nginx |
| APP_CMD    |         | Command for start application process                        |
| OS_VERSION |         | Ubuntu OS version name                                       |

### Additional scripts

- NodeJS
  If you need to use NodeJS for your application, just use the following example in your Dockerfile:

```Dockerfile
FROM web_focal as base

ARG NODEJS_VERSION=16.13.2
ENV NODEJS_VERSION=${NODEJS_VERSION} \
    PATH=/usr/local/nvm/versions/node/v${NODEJS_VERSION}/bin/:${PATH}

RUN get-nodejs

FROM base as build

RUN npm ci \
    && make build \
    && npm prune --production
```
