$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__) + '/lib')
require 'rubygems'
require 'rake/gempackagetask'

require 'rubis' 
require 'rubis/tasks/get_redis_commands'

spec = Gem::Specification.new do |s|
  s.name = 'rubis'
  s.version = Rubis::VERSION
  s.homepage = 'http://github.com/ryanbriones/rubis'
  s.summary = 'API for redis-backed ruby objects'
  s.files = FileList['[A-Z]*', 'lib/rubis.rb', 'lib/rubis/*.rb', 'spec/*']
  s.has_rdoc = false
  s.author = 'Ryan Carmelo Briones'
  s.email = 'ryan.briones@brionesandco.com'

  s.add_dependency 'redis'
  s.add_development_dependency 'nokogiri'
end
 
package_task = Rake::GemPackageTask.new(spec) {}
 
desc "Write out #{spec.name}.gemspec"
task :build_gemspec do
  File.open("#{spec.name}.gemspec", "w") do |f|
    f.write spec.to_ruby
  end
end
 
task :default => [:build_gemspec, :gem]
