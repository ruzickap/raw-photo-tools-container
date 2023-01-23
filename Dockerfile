FROM alpine:3

ENV HOME /tmp

# hadolint ignore=DL3018
RUN set -eux && \
    apk add --no-cache darktable exiftool && \
    mkdir -pv /.config/darktable /usr/share/locale

USER nobody

WORKDIR /mnt
