FROM ruby

# RUN apt-get update \
#   && apt-get install -y --no-install-recommends \
#   postgresql-client \
#   && rm -rf /var/lib/apt/lists/*

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

WORKDIR /usr/src/app
COPY Gemfile* ./
RUN gem install bundler:1.17.2
RUN bundle install
COPY . .

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]