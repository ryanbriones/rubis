module Rubis
  module Namespace
    def self.extended(base)
      base.class_eval { @rubis_namespace = base.to_s.downcase.gsub('::', ':') }
    end

    def redis_namespace
      self.class_eval { @rubis_namespace }
    end

    private

    def redis
      Rubis.redis
    end

    def method_missing(method, *args, &block)
      if Rubis::REDIS_COMMANDS.include?(method.to_s) || Redis::ALIASES.keys.include?(method.to_s)
        key = "#{redis_namespace}:#{args.shift}"
        redis.send(method, key, *args, &block)
      else
        super
      end
    end
  end
end
