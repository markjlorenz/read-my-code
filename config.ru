class App

  def self.call(env)
    new(env).response
  end

  def initialize(env)
    @env = env
  end

  def response
    [200, {'Content-Type'=>'text/html'}, StringIO.new("all good here.")]
  end

end

run App
