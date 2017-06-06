module ReadCache
  class << self
    def redis
      @redis ||= Redis::Namespace.new('mini_forum', redis: Redis.new)
    end
  end
end
