require 'environment'

# need to stub this in tests somehow...
class StubMe
  @@secret = nil
  def self.secret
    return if @@secret == false
    @@secret = File.read('config/secret') rescue false
  end
end

get "/magick" do
  if StubMe.secret
    hash = MD5.md5('xxx' + params.reject{|k,v| k=='hash' }.sort.inspect)
    return "Hash does not match!" if hash != params[:hash].to_s
  end

  image = MiniMagick::Image.from_blob(open(params[:url]).read)
  image.resize params[:size]
  image.to_blob
end