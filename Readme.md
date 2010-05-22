Sinatra app to manipulate images given by url via mini_magick and image_magick.

    # resize
    /magick?url=http://github.com/images/modules/header/logov3.png&size=200x100

    # resize to 200 width / unlimited height
    /magick?url=http://github.com/images/modules/header/logov3.png&size=200x

### Security
If a `config/secret` is given, only requests with params hashed with this secret will be accepted.

    def magick_query(params)
      require 'md5'
      hash = MD5.md5('my secret' + params.map{|kv| kv.to_s }.sort.to_s)
      params = params.merge(:hash => hash)
      params.map{|k,v| "#{k}=#{v}"}.join('&')
    end

    `curl http://localhost/magick?#{magick_query(params)}`

### Performance
Add chaching server infront of the app, e.g. Varnish or Rack::Cache.

TODO
=====
 - add cropping

Author
======
[Michael Grosser](http://pragmatig.wordpress.com)  
grosser.michael@gmail.com  
Hereby placed under public domain, do what you want, just do not hold me accountable...