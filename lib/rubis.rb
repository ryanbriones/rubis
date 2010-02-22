require 'redis'

module Rubis
  VERSION = '0.0.1'
  
  autoload :Namespace, 'rubis/namespace'
  
  REDIS_COMMANDS = [ "auth", "bgrewriteaof", "bgsave",
                     "blpop", "brpop", "dbsize",
                     "decr", "decrby", "del",
                     "exists", "expire", "flushall",
                     "flushdb", "get", "getset",
                     "incr", "incrby", "info",
                     "keys", "lastsave", "lindex",
                     "llen", "lpop", "lpush",
                     "lrange", "lrem", "lset",
                     "ltrim", "mget", "monitor",
                     "move", "mset", "msetnx",
                     "quit", "randomkey", "rename",
                     "renamenx", "rpop", "rpoplpush",
                     "rpush", "sadd", "save",
                     "scard", "sdiff", "sdiffstore",
                     "select", "set", "setnx",
                     "shutdown", "sinter", "sinterstore",
                     "sismember", "slaveof", "smembers",
                     "smove", "sort", "spop",
                     "srandmember", "srem", "sunion",
                     "sunionstore", "ttl", "type",
                     "zadd", "zcard", "zincrby",
                     "zrange", "zrangebyscore", "zrem",
                     "zremrangebyscore", "zrevrange", "zscore" ]
  
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
