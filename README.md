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
