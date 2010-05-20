require 'environment'

# need to stub this in tests somehow...
class SinatraMagick
  class SecretKeeper
    def self.secret
      @@secret ||= File.read('config/secret') rescue ''
    end
  end
end

get "/magick" do
  [:url, :size].each{|k| raise "i need #{k}" if params[k].to_s == '' }

  if SinatraMagick::SecretKeeper.secret != ''
    hash = MD5.md5('xxx' + params.reject{|k,v| k=='hash' }.sort.inspect)
    return "Hash does not match!" if hash != params[:hash].to_s
  end

  image = MiniMagick::Image.from_blob(open(params[:url]).read)
  image.resize params[:size]
  image.to_blob
end