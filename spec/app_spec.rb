require 'spec/spec_helper'

require 'sinatra'
require 'rack/test'
require 'app'

describe 'App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application.new
  end

  it "xxx" do
    get 'magick/xxx'
  end
end