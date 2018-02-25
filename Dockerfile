FROM alpine:3.7

ARG HUGO_VERSION=0.36.1
ARG HUGO_SHA=9e06d950b7f99286d68573769a8c08476c7a76b5
ARG HUGO_BUILD=hugo_${HUGO_VERSION}_Linux-64bit

WORKDIR /src
RUN apk add --no-cache --virtual deps curl tar \
    && mkdir "/tmp/${HUGO_BUILD}" \
    && curl -SL -o /tmp/${HUGO_BUILD}/hugo.tar.gz https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BUILD}.tar.gz \
    && echo "${HUGO_SHA} */tmp/${HUGO_BUILD}/hugo.tar.gz" | sha1sum -c - \
    && tar fxz /tmp/${HUGO_BUILD}/hugo.tar.gz -C /usr/local/bin hugo \
    && rm -rf "/tmp/${HUGO_BUILD}" \
    && apk del deps

VOLUME ["/src", "/public"]
EXPOSE 1313

ENTRYPOINT ["hugo"]
CMD ["server", "--baseURL=http://localhost:1313", "--bind=0.0.0.0", "--buildDrafts", "--buildFuture"]