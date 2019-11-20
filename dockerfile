# Start from the official ruby image, then update and install JS & DB
FROM ruby:2.6.3
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Create a directory for the application and use it
RUN mkdir /myapp
WORKDIR /myapp

# Gemfile and lock file need to be present, they'll be overwritten immediately
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

# Install gem dependencies
# RUN bundle install
RUN bundle install
COPY . /myapp

# This script runs every time the container is created, necessary for rails
CMD ["rails", "server", "-b", "0.0.0.0"]
EXPOSE 3000

# Start rails
