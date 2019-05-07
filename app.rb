require 'sinatra'
require "sinatra/reloader"

class App < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  # output log to STDOUT
  set :logging, true

  get '/' do
    if ENV["R_USERNAME"] && ENV["R_PASSWORD"]
      protected!
    end

    # Do not filter by HTTP header. Because it is useful for development
    # to display all the information.
    # @http_headers = request.env.select { |k, v| k.start_with?('HTTP_') }
    @http_headers = request.env.sort

    @request = request
    @title = "View Headers"
    erb :index
  end

  helpers do
    def cookie_bueautify(txt)
      txt.gsub(/;/, ";<br>")
    end

    def authorized?
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
      @auth.provided? &&  @auth.basic? &&
        @auth.credentials &&
        @auth.credentials == [ ENV["R_USERNAME"], ENV["R_PASSWORD"] ]
    end

    def protected!
      unless authorized?
        response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
        throw(:halt, [401, "please your login name & password\n"])
      end
    end
  end

end
