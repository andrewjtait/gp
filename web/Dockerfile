FROM ruby:3.3.1-slim AS base

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  build-essential \
  libvirt-dev

RUN useradd -r -d /opt/gp -m -s /bin/bash gp -u 900
USER gp
RUN mkdir -p /opt/gp/app
WORKDIR /opt/gp/app

RUN gem install bundler -v 2.5.9 --no-doc

COPY Gemfile Gemfile.lock .ruby-version ./
RUN bundle config set --local frozen 'true'  \
  && bundle install -j 4

COPY --chown=gp . .

RUN bundle exec rake assets:precompile

EXPOSE 3000

ENTRYPOINT ["/docker/entrypoint.sh"]
CMD ["bin/rails", "s", "-b", "0.0.0.0"]
