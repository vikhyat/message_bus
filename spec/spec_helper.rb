require 'thin'
require 'lib/fake_async_middleware'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
  config.mock_with :rspec do |mocks|
    mocks.syntax = :should
  end
end

def wait_for(timeout_milliseconds)
  timeout = (timeout_milliseconds + 0.0) / 1000
  finish = Time.now + timeout
  t = Thread.new do
    while Time.now < finish && !yield
      sleep(0.001)
    end
  end
  t.join
end


