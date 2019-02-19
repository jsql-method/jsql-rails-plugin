FROM ruby:2.6
COPY . /app
WORKDIR /app
RUN gem install bundler -v 1.17.2
RUN gem install http rails
RUN BUNDLE_SILENCE_ROOT_WARNING=1 && bundle install
CMD rails server -b 0.0.0.0 -p 3000 -e test
