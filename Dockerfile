FROM apline:3.7

ARG HUGO_VERSION=0.36.1

WORKDIR /src
RUN apk add --no-cache --virtual deps curl tar \
    && curl -SLO https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz \
    && tar fxz hugo_${HUGO_VERSION}_Linux-64bit.tar.gz -C /usr/local/bin --strip-components=1 \
    && rm hugo_${HUGO_VERSION}_Linux-64bit.tar.gz \
    && mv /usr/local/bin/hugo_${HUGO_VERSION}_linux_amd64 /usr/local/bin/hugo \
    && apk del deps

VOLUME ["/src", "/public"]
EXPOSE 1313

ENTRYPOINT ["hugo"]
CMD ["server", "--baseURL=http://localhost:1313", "--bind=0.0.0.0", "--buildDrafts", "--buildFuture"]