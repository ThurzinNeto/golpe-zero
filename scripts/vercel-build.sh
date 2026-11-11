#!/usr/bin/env bash
set -euo pipefail

FLUTTER_VERSION="3.47.9"
FLUTTER_ROOT="${HOME}/.flutter"

if [ ! -x "${FLUTTER_ROOT}/bin/flutter" ]; then
  git clone --depth 1 --branch "${FLUTTER_VERSION}" \
    https://github.com/flutter/flutter.git "${FLUTTER_ROOT}"
fi

"${FLUTTER_ROOT}/bin/flutter" config --no-analytics
"${FLUTTER_ROOT}/bin/flutter" build web --release --base-href /
