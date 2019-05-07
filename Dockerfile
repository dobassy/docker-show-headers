FROM ruby:2.6-alpine

COPY . /app
WORKDIR /app
RUN \
  bundle install --path vendor/bundle

ENV RACK_ENV production
EXPOSE 8080
CMD [ "bundle", "exec", "ruby", "./app.rb", \
      "-o", "0.0.0.0", \
      "-p", "8080" ]
