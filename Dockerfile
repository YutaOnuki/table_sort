FROM ruby:2.4.0

ENV LANG C.UTF-8

ENV WORKING_DIR /table_sort_app

WORKDIR $WORKING_DIR

RUN apt-get update -qq && \
    apt-get install -y sudo build-essential libpq-dev postgresql-client

RUN apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install nodejs

ADD ./Gemfile $WORKING_DIR

ADD ./Gemfile.lock $WORKING_DIR

RUN gem install bundler

RUN bundle install -j2
