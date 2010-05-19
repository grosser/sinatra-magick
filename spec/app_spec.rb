require 'spec/spec_helper'

require 'sinatra'
require 'rack/test'
require 'app'

describe 'App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application.new
  end

  it "resizes" do
    get 'magick?url=http%3A%2F%2Fgithub.com%2Fimages%2Fmodules%2Fheader%2Flogov3.png&size=200x'
    File.open('/tmp/xxx.png', 'w'){|f| f.write last_response.body}
    `identify /tmp/xxx.png`.should =~ /PNG 200x90 /
  end
end