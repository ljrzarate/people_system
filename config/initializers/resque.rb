Resque.redis = Redis.new(url: (ENV["REDIS_URL"] || 'http://0.0.0.0:6379'))
Resque.after_fork = Proc.new { ActiveRecord::Base.establish_connection }
