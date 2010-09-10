require 'rubygems'
require 'rake'
gemspec = Dir.new(".").find{|f| f =~ /.*gemspec/}
load gemspec

task :test do
	sh 'ruby test_*.rb'
end

task :package do
  sh "gem build #{gemspec}"
end

task :install => [:package] do
  sh "sudo gem install #{SPEC.name}-#{SPEC.version.version}.gem"
end

task :push => [:package] do
  sh "gem push #{SPEC.name}-#{SPEC.version.version}.gem"
end
task :commit do
  sh "git add -A"
  sh "git commit -m '#{ENV['m'] || "update..."}'"
end
task :deploy => [:commit] do
  sh "git push heroku master"
end

task :git => [:commit] do
  sh "git push origin master"
end
