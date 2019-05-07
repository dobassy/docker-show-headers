#!/bin/sh
set -e

case ${1} in
  start:withpassword)
    echo "Generate username..."
    username="user"
    echo "Generate password..."
    password=$(cat /dev/urandom | base64 | fold -w 20 | head -n 1)
    echo "  @@@@@@@@@ important @@@@@@@@@@@@@@@@@@"
    echo "  onetime username: ${username}"
    echo "  onetime password: ${password}"
    echo "  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    echo "The above information is valid only while this container is runnning."
    export R_USERNAME=${username}
    export R_PASSWORD=${password}
    echo "Start with authentication"
    exec bundle exec rackup -o 0.0.0.0 -p 8080
    ;;

  *)
    echo "Start without authentication"
    exec "$@"
    ;;
esac
