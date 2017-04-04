FROM ruby:2.3.1-slim

MAINTAINER Vadim Konik <helaxe@gmail.com>

RUN apt-get update && apt-get install -qq -y build-essential git nodejs libpq-dev imagemagick postgresql-client-9.4 --fix-missing --no-install-recommends

ENV INSTALL_PATH /unsplash
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY Gemfile Gemfile

RUN bundle install

RUN pwd

COPY . .

RUN bundle exec rake RAILS_ENV=development DATABASE_URL=postgresql://test:123@127.0.0.1/unsplash SECRET_TOKEN=pickasecuretoken assets:precompile

VOLUME ["$INSTALL_PATH/public"]

CMD bundle exec puma