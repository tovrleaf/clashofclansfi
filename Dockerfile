FROM alpine:3.7

ARG HUGO_VERSION=0.36.1

WORKDIR /src
RUN apk add --no-cache --virtual deps curl tar \
    && curl -SLO https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz \
    && tar fxz hugo_${HUGO_VERSION}_Linux-64bit.tar.gz -C /usr/local/bin hugo \
    && rm hugo_${HUGO_VERSION}_Linux-64bit.tar.gz \
    && apk del deps

VOLUME ["/src", "/public"]
EXPOSE 1313

ENTRYPOINT ["hugo"]
CMD ["server", "--baseURL=http://localhost:1313", "--bind=0.0.0.0", "--buildDrafts", "--buildFuture"]