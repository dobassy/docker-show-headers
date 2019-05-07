FROM ruby:2.6-alpine

COPY . /app
WORKDIR /app
RUN \
  bundle install --path vendor/bundle

ENV RACK_ENV production
EXPOSE 8080
# ENTRYPOINT ["/app/entrypoint.sh"]
CMD [ "bundle", "exec", "rackup", \
      "-o", "0.0.0.0", \
      "-p", "8080" ]
