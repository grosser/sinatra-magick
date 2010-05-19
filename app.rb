require 'environment'

get "/magick" do
  image = MiniMagick::Image.from_blob(open(params[:url]).read)
  image.resize params[:size]
  image.to_blob
end