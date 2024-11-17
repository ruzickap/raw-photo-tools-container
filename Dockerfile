FROM alpine:3@sha256:1e42bbe2508154c9126d48c2b8a75420c3544343bf86fd041fb7527e017a4b4a

ENV HOME /tmp

RUN set -eux && \
    apk add --no-cache darktable exiftool && \
    mkdir -pv /.config/darktable /usr/share/locale

USER nobody

HEALTHCHECK NONE

WORKDIR /mnt
