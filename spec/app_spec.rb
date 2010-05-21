require 'spec/spec_helper'

require 'sinatra'
require 'rack/test'
require 'app'

describe 'App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application.new
  end

  before do
    @url = 'http://github.com/images/modules/header/logov3.png'
    @escaped_url = Rack::Utils.escape_html @url
    SinatraMagick::SecretKeeper.stub!(:secret).and_return ''
  end

  it "resizes" do
    get "magick?url=#{@escaped_url}&size=200x"
    File.open('/tmp/xxx.png', 'w'){|f| f.write last_response.body}
    `identify /tmp/xxx.png`.should =~ /PNG 200x90 /
  end

  it "returns error when hash does not match" do
    SinatraMagick::SecretKeeper.stub!(:secret).and_return 'xxx'
    get "magick?url=#{@escaped_url}&size=200x"
    last_response.body.should == 'Hash does not match!'
  end

  it "resizes if hash does match" do
    SinatraMagick::SecretKeeper.stub!(:secret).and_return 'xxx'
    hash = MD5.md5('xxx' + {'url' => @url, 'size' => '200x'}.sort.inspect)
    get "magick?url=#{@escaped_url}&size=200x&hash=#{hash}"
    last_response.body.should_not == 'Hash does not match!'
  end

  it "expires in the future" do
    get "magick?url=#{@escaped_url}&size=200x"
    last_response.headers["Cache-Control"].should == "public, max-age=63072000"
  end

  it "sets correct mim type" do
    get "magick?url=#{@escaped_url}&size=200x"
    last_response.headers["Content-Type"].should == "image/png"
  end
end