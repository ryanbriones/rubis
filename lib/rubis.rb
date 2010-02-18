require 'redis'

module Rubis
  VERSION = '0.0.1'
  
  autoload :Namespace, 'rubis/namespace'
  
  def self.redis=(connection)
    case connection
    when String
      host, port, db = server.split(':')
      @redis = Redis.new(:host => host, :port => port,
                         :thread_safe => true, :db => db)
    when Redis
      @redis = server
    else
      raise "I don't know what to do with #{connection.inspect}"
    end
  end

  def self.redis
    return @redis if @redis
  end
end
