class App

  def self.call(env)
    new(env).response
  end

  def initialize(env)
    @env = env
  end

  def response
    if credentials.valid?
      [200, {'Content-Type'=>'text/plain'}, [ENV.fetch("SECRET")]]
    else
      [401, {'Content-Type'=>'text/plain'}, StringIO.new("you didn't say the magic word.")]
    end
  end

  def request
    @request ||= Rack::Request.new(@env)
  end

  def credentials
    @credentials ||= Credentials.new(*request.body.read.split(":"))
  end

  Credentials = Struct.new(:username, :password) do
    def valid?
      username == ENV.fetch("USERNAME") \
      && password == ENV.fetch("PASSWORD")
    end
  end

end

run App
