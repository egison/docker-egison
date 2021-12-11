#!/usr/bin/env bash

# Usage:
#
# Build Only:
#   $ TEST=1 ./deploy.sh
# Build && Push
#   $ ./deploy.sh

set -euo pipefail

TEST="${TEST:-}"
# REPO="egison/egison"
REPO="eggplanter/egison"
EGISON_VERSIONS=(

  #######
  # 0.x #
  #######

  # 0.1
  # 0.1.1 0.1.2 0.1.2.1 0.1.2.2 0.1.2.3 0.1.2.4 0.1.2.5
  # 0.2.0.0 0.2.0.1 0.2.0.2
  # 0.2.1.0 0.2.1.1
  # 0.3.0.0 0.3.0.1 0.3.0.2 0.3.0.3
  # 0.3.1.0 0.3.1.1
  # 0.4.0.0

  #######
  # 1.x #
  #######

  # 1.0
  # 1.0.1 1.0.2 1.0.3 1.0.4 1.0.5 1.0.6 1.0.7
  # 1.1.0 1.1.1
  # 1.2.0 1.2.1 1.2.2 1.2.3

  #######
  # 2.x #
  #######

  # 2.0.0 2.0.1 2.0.2 2.0.3 2.0.4
  # 2.1.0 2.1.1 2.1.2 2.1.3 2.1.4 2.1.5 2.1.6 2.1.7 2.1.8 2.1.9 2.1.10
  # 2.1.11 2.1.12 2.1.13 2.1.14 2.1.15 2.1.16
  # 2.2.0 2.2.1 2.2.2 2.2.3
  # 2.3.0 2.3.1 2.3.2 2.3.3
  # 2.3.4 2.3.5 2.3.6 2.3.7 2.3.8 2.3.9 2.3.10
  # 2.4.0 2.4.1 2.4.2 2.4.3 2.4.4 2.4.5 2.4.6 2.4.7

  #######
  # 3.x #
  #######

  # 3.0.0 3.0.1 3.0.2 3.0.3 3.0.4 3.0.5 3.0.6 3.0.7 3.0.8 3.0.9 3.0.10

  #################################################
  #### < -- egison-tutorial is available -- >  ####
  #################################################

  # 3.0.11 3.0.12
  # 3.1.0 3.1.1
  # 3.2.0 3.2.1 3.2.2 3.2.3 3.2.4 3.2.5 3.2.6 3.2.7 3.2.8 3.2.9 3.2.10
  # 3.2.11 3.2.12 3.2.13 3.2.14 3.2.15 3.2.16 3.2.17 3.2.18 3.2.19 3.2.20
  # 3.2.21 3.2.22 3.2.23 3.2.24
  # 3.3.0 3.3.1 3.3.2 3.3.3 3.3.4 3.3.5 3.3.6 3.3.7 3.3.8 3.3.9 3.3.10
  # 3.3.11 3.3.12 3.3.13 3.3.14 3.3.15 3.3.16 3.3.17
  # 3.4.0
  # 3.5.0 3.5.1 3.5.2 3.5.3 3.5.4 3.5.5 3.5.6 3.5.7 3.5.8 3.5.9 3.5.10
  # 3.6.0 3.6.1 3.6.2 3.6.3 3.6.4 3.6.5
  # 3.7.0 3.7.1 3.7.2 3.7.3 3.7.4 3.7.5 # -> x
  # 3.7.6 3.7.7 3.7.8 3.7.9 3.7.10 3.7.11 # -> x
  # 3.7.12 3.7.13 3.7.14 # -> x
  3.8.0 3.8.1 3.8.2 3.9.0 3.9.1 3.9.2 # -> x
  # 3.9.3 3.9.4 3.10.0 3.10.1 3.10.2 3.10.3 # -> haskell:8 (8.10.7)

  #######
  # 4.x #
  #######

  # 4.0.0 4.0.1 4.0.2 4.0.3 # -> haskell:8 (8.10.7)
  # 4.1.0 4.1.1 4.1.2 # -> x
)
LATEST_VERSION="4.1.2"
# LATEST_VERSION="${EGISON_VERSIONS[${#EGISON_VERSIONS[@]} - 1]}"
HASKELL_VERSION=8.10

if ! [ -f "./Dockerfile" ]; then
  echo "err: Dockerfile is not found." >&2
  exit 1
fi

ok=()
ng=()
for v in "${EGISON_VERSIONS[@]}"; do
  echo "[[[ $v ]]]"

  if
    docker build -t "${REPO}:${v}" \
      --build-arg EGISON_VERSION="$v" \
      --build-arg HASKELL_VERSION="$HASKELL_VERSION" .
  then
    ok+=("$v")
    [ "$TEST" = "1" ] || docker push "${REPO}:${v}"
  else
    ng+=("$v")
  fi
done

echo OK: "${ok[@]}"
echo NG: "${ng[@]}"

exit

echo "[[[ latest ]]]]"

docker build -t "${REPO}:latest" \
  --build-arg EGISON_VERSION="$LATEST_VERSION" \
  --build-arg HASKELL_VERSION="$HASKELL_VERSION" .

[ "$TEST" = "1" ] || docker push "${REPO}:latest"
