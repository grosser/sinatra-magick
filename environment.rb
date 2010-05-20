require 'rubygems'
require 'bundler'
Bundler.setup
Bundler.require

require 'md5'

if File.exist?('config/newreclic.yml')
  NewRelic::Control.instance.init_plugin(:env => Sinatra::Application.environment.to_s)
end