$LOAD_PATH << File.dirname(__FILE__)
require 'app'
disable :run
run Sinatra::Application