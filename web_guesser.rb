require 'sinatra'
require 'sinatra/reloader'

get '/' do
  "#{rand(4)}"
end
