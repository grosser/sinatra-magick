$LOAD_PATH << File.dirname(__FILE__)
require 'app'
disable :run

class Sinatra::Base
  register Sinatra::Synchrony
end

run Sinatra::Application
