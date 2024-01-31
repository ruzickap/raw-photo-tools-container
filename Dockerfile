FROM alpine:3

ENV HOME /tmp

RUN set -eux && \
    apk add --no-cache darktable exiftool && \
    mkdir -pv /.config/darktable /usr/share/locale

USER nobody

HEALTHCHECK NONE

WORKDIR /mnt
