#!/usr/bin/env bash

###################################
#                                 #
# Usage:                          #
#                                 #
# Build Only:                     #
#   $ TEST=1 ./deploy.sh 8        #
# Build && Push                   #
#   $ ./deploy.sh 8 egison/egison #
#                                 #
###################################

set -euo pipefail

if ! command -v docker &> /dev/null; then
  echo "docker is not found." >&2
  exit 1
elif ! [[ $# =~ ^[12]$ ]]; then
  echo 'usage: '"$0"' <haskell version> [dockerhub repo]' >&2
  echo 'set "TEST=1" if you want to skip pushing.' >&2
  exit 1
fi

HASKELL_VERSION="${1:-8}"
REPO="${2:-egison/egison}"

TEST="${TEST:-}"

EGISON_VERSIONS=(
  # 0.x-3.8.x is failed to build on haskell:7 - 9

  #######
  # 3.x #
  #######

  3.9.3 3.9.4
  3.10.0 3.10.1 3.10.2 3.10.3

  #######
  # 4.x #
  #######

  4.0.0 4.0.1 4.0.2 4.0.3
  4.1.0 4.1.1 4.1.2
)
LATEST_VERSION="${EGISON_VERSIONS[${#EGISON_VERSIONS[@]} - 1]}"

if ! [ -f "./Dockerfile" ]; then
  echo "err: Dockerfile is not found." >&2
  exit 1
fi

ok=("OK:")
ng=("NG:")
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

echo "[[[ latest ]]]]"
if
  docker build -t "${REPO}:latest" \
    --build-arg EGISON_VERSION="$LATEST_VERSION" \
    --build-arg HASKELL_VERSION="$HASKELL_VERSION" .
then
  ok+=("latest")
  [ "$TEST" = "1" ] || docker push "${REPO}:latest"
else
  ng+=("latest")
fi

echo "${ok[@]}"
echo "${ng[@]}"
