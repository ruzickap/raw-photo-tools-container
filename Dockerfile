FROM alpine:3@sha256:c5b1261d6d3e43071626931fc004f70149baeba2c8ec672bd4f27761f8e1ad6b

ENV HOME /tmp

RUN set -eux && \
    apk add --no-cache darktable exiftool && \
    mkdir -pv /.config/darktable /usr/share/locale

USER nobody

HEALTHCHECK NONE

WORKDIR /mnt
