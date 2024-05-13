FROM ruby:3.3.1-slim AS base

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  build-essential \
  libvirt-dev

RUN useradd -r -d /opt/systmonline -m -s /bin/bash systmonline -u 900
USER systmonline
RUN mkdir -p /opt/systmonline/app
WORKDIR /opt/systmonline/app

RUN gem install bundler -v 2.5.9 --no-doc

COPY Gemfile Gemfile.lock .ruby-version ./
RUN bundle config set --local frozen 'true'  \
  && bundle install -j 4

COPY --chown=systmonline . .

EXPOSE 8000

CMD ["ruby", "server.rb"]
