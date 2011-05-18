$LOAD_PATH << File.dirname(__FILE__)
require 'app'
require 'sinatra/synchrony'
disable :run

class Sinatra::Base
  register Sinatra::Synchrony
end

run Sinatra::Application
