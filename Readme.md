EventMachine-driven Sinatra app to manipulate images given by url via evented-magick (image-magick).

    # resize
    /magick?url=http://github.com/images/modules/header/logov3.png&size=200x100

    # resize to 200 width / unlimited height
    /magick?url=http://github.com/images/modules/header/logov3.png&size=200x

### Startup

    sudo gem install bundler
    bundle install
    thin start
    curl localhost:3000/...see above...

### As Middleware
TODO

### Security
If the file `config/secret` (e.g. including 'my secret') exists, only requests with params hashed with this secret will be accepted.

    require 'digest/md5'

    def magick_query(params)
      hash = Digest::MD5.hexdigest('my secret' + params.map(&:to_s).sort.to_s)
      params = params.merge(:hash => hash)
      params.map{|k,v| "#{k}=#{v}"}.join('&')
    end

    `curl http://localhost/magick?#{magick_query(:url=>'xxx', :size=>'100x200')}`

### Performance
Everything is evented, so its parallel and fast.<br/>
Add caching server infront of the app, e.g. Varnish or Rack::Cache
to mak it production-ready.

TODO
=====
 - add cropping

Author
======
[Michael Grosser](http://pragmatig.wordpress.com)
grosser.michael@gmail.com
Hereby placed under public domain, do what you want, just do not hold me accountable...
