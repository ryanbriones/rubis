begin
  require 'nokogiri'
  require 'open-uri'
  
  namespace :rubis do
    desc "Get list of Redis commands from Redis Command Wiki"
    task :get_redis_commands do
      a = Nokogiri(open('http://code.google.com/p/redis/wiki/CommandReference'))
      b = a.search('.vt li a').map { |b| b.text.downcase }.sort

      out = "[ "
      b.each_slice(3) do |group|
        out << group.map { |c| c.inspect }.join(', ')
        out << ",\n"
      end
      out = out[0..-3]
      out << " ]"
      puts out
    end
  end
rescue LoadError
  namespace :rubis do
    desc "Get list of Redis commands from Redis Command Wiki"
    task :get_redis_commands do
      STDERR.puts "You need the Nokogiri gem installed to run this command"
    end
  end
end