FROM alpine:3@sha256:56fa17d2a7e7f168a043a2712e63aed1f8543aeafdcee47c58dcffe38ed51099

ENV HOME /tmp

RUN set -eux && \
    apk add --no-cache darktable exiftool && \
    mkdir -pv /.config/darktable /usr/share/locale

USER nobody

HEALTHCHECK NONE

WORKDIR /mnt
