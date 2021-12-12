ARG HASKELL_VERSION
FROM haskell:$HASKELL_VERSION
LABEL maintainer="Satoshi Egi <egi@egison.org>"

ARG EGISON_VERSION
ENV EGISON_VERSION ${EGISON_VERSION:-4.1.2}

# https://hackage.haskell.org/package/egison
# https://hackage.haskell.org/package/egison-tutorial

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# with tutorial: 3.0.12 - 999.9.9

RUN cabal update && \
  if [ "$(echo -e "3.0.12\\n${EGISON_VERSION}\n999.9.9" | \
  sort -V | head -2)" = "${EGISON_VERSION}" ]; then \
  cabal install \
  egison-${EGISON_VERSION} \
  egison-tutorial; \
  else \
  cabal install \
  egison-${EGISON_VERSION}; \
  fi

WORKDIR /docker

ENTRYPOINT ["egison"]
