require 'json'
require 'webrick'

module Phase4
  class Session

    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      cookie = req.cookies.detect { |cookie| cookie.name == '_rails_lite_app' }
      unless cookie.nil?
        @cookie = JSON.parse(cookie.value)
      else
        @cookie = {}
      end
    end

    def [](key)
      @cookie[key]
    end

    def []=(key, val)
      @cookie[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      if @cookie.empty?
        cookie_hash =  {xyz: 'abc'}
      else
        cookie_hash = @cookie
      end

      new_cookie = WEBrick::Cookie.new('_rails_lite_app',
                                      cookie_hash.to_json)
      res.cookies << new_cookie

    end
  end
end
