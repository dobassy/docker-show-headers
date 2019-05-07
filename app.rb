require 'sinatra'
require "sinatra/reloader"

class App < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end
end

get '/' do
  headers = Hash.new

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
end
