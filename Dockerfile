FROM ruby:2.3-slim
MAINTAINER Otavio Medeiros <otaviorm@gmail.com>

RUN apt-get update && apt-get install -qq -y build-essential patch --fix-missing --no-install-recommends

ENV INSTALL_PATH /app
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

ADD Gemfile Gemfile
RUN bundle install

COPY . .

CMD bundle exec puma -C config/puma.rb
