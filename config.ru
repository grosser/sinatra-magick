$LOAD_PATH << File.dirname(__FILE__)
require 'app'
require 'sinatra/synchrony'
disable :run

run Sinatra::Application
