FROM ruby:2.6
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /rails_bootstrap
WORKDIR /rails_bootstrap
COPY Gemfile /rails_bootstrap/Gemfile
COPY Gemfile.lock /rails_bootstrap/Gemfile.lock
RUN bundle install
COPY . /rails_bootstrap

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
