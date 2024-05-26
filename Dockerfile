FROM alpine:3@sha256:77726ef6b57ddf65bb551896826ec38bc3e53f75cdde31354fbffb4f25238ebd

ENV HOME /tmp

RUN set -eux && \
    apk add --no-cache darktable exiftool && \
    mkdir -pv /.config/darktable /usr/share/locale

USER nobody

HEALTHCHECK NONE

WORKDIR /mnt
