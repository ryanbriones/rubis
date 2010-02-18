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
      key = "#{redis_namespace}:#{args.shift}"
      redis.send(method, key, *args, &block)
    end
  end
end
