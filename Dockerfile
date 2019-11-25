FROM haskell:latest
MAINTAINER Satoshi Egi

RUN cabal update
RUN cabal install \
    egison \
    egison-tutorial

WORKDIR /docker

ENTRYPOINT ["egison"]
CMD ["--prompt", "> "]
