require 'environment'

# need to stub this in tests somehow...
class SinatraMagick
  class SecretKeeper
    def self.secret
      @@secret ||= File.read('config/secret') rescue ''
    end
  end
end

error_logger = Logger.new('log/errors.log', 3, 10*1024*1024)
error do
  error = request.env['sinatra.error']
  info = "Application error\n#{error}\n#{error.backtrace.join("\n")}"

  error_logger.info info
  Kernel.puts info

  'Application error'
end

get "/magick" do
  [:url, :size].each{|k| raise "i need #{k}" if params[k].to_s == '' }

  if SinatraMagick::SecretKeeper.secret != ''
    flat_params = params.reject{|k,v| k=='hash' }.map{|kv|kv.to_s}.sort.to_s
    hash = MD5.md5(SinatraMagick::SecretKeeper.secret + flat_params)
    return "Hash does not match!" if hash != params[:hash].to_s
  end

  expires 2*365*24*60*60, :public

  image = MiniMagick::Image.from_blob(open(params[:url]).read)
  image.resize params[:size]
  type = File.extname(params[:url].sub(/\?.*/,''))
  send_file image.instance_variable_get('@path'), :disposition => 'inline', :type => type
end