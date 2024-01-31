# raw-photo-tools-container

[![Container build](https://github.com/ruzickap/raw-photo-tools-container/actions/workflows/container-build.yml/badge.svg)](https://github.com/ruzickap/raw-photo-tools-container/actions/workflows/container-build.yml)

Repository for building container to help manage RAW photos.

* darktable
* exiftool

Container registry: <https://quay.io/repository/petr_ruzicka/raw-photo-tools?tab=tags>

Example:

```bash
docker run --rm -it --volume="${PWD}:/mnt" quay.io/petr_ruzicka/raw-photo-tools sh

darktable-cli --verbose "20221014-203700.arw" "20221014-203700.jpg" \
  --core --conf plugins/imageio/format/jpeg/quality=95
```

Complex example:

```bash
#!/usr/bin/env sh

set -euxo pipefail

docker run --rm -i --user "$(id -u "${USER}"):$(id -g "${USER}")" -v "${PWD}:/mnt" --workdir="/mnt" quay.io/petr_ruzicka/raw-photo-tools:latest /bin/sh << \EOF

for XMP_FILE in *.xmp; do
  RAW_FILE=$(exiftool -DerivedFrom $XMP_FILE | sed -e 's/^Derived From\s*:\s\(.*\)/\1/')
  RAW_FILE_NAME="${XMP_FILE%.*}"
  FILE_NAME="${RAW_FILE%.*}"

  echo "*** ${XMP_FILE} [${RAW_FILE}] [${FILE_NAME}]"

  if [ "${RAW_FILE_NAME}" != "${RAW_FILE}" ]; then
    echo "Raw file name mentioned in xmp (xmpMM:DerivedFrom) file does not match the raw file taken from \"$RAW_FILE_NAME\" !"
    exit 1
  fi

  test -f "${RAW_FILE}" || ( echo "${RAW_FILE} does not exists !"; exit 2 )

  if [ ! -f "${FILE_NAME}.jpg" ]; then
    darktable-cli --verbose "${RAW_FILE}" "${XMP_FILE}" "${FILE_NAME}.jpg" --core --conf plugins/imageio/format/jpeg/quality=95
    exiftool '-filename<CreateDate' -d %Y%m%d-%H%M%S%%-c.%%le "-filemodifydate<datetimeoriginal#" ${FILE_NAME}*.jpg
  else
    echo "*** Skipping ${FILE_NAME}.jpg - already exists"
  fi
done

EOF
```
