# Copyright 2017 oleks <oleks@oleks.info>
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. A copy of the License
# text is included alongside this file as LICENSE.md.
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
# License for the specific language governing permissions and limitations under
# the License.

FROM alpine:3.5

ARG username=idris
ARG name=oleks
ARG email=oleks@oleks.info
ARG idris=0.99.2

MAINTAINER ${name} <${email}>

RUN apk --no-cache add alpine-sdk

RUN \
  echo http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    >> /etc/apk/repositories

RUN apk --no-cache add zlib-dev ncurses-dev ghc cabal

RUN adduser -D -u 1000 ${username}
USER ${username}

WORKDIR /home/${username}/

RUN \
  wget https://github.com/idris-lang/Idris-dev/archive/v${idris}.zip && \
  unzip *.zip && rm *.zip

RUN cd Idris-dev* && cabal update && make

ENV PATH=/home/${username}/.cabal/bin:$PATH

CMD ["idris"]
