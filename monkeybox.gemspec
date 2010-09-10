
require 'rubygems'

SPEC = Gem::Specification.new do |spec|
  spec.name = 'monkeybox'
  spec.author = 'Dominic Tarr'
  spec.email = 'dominic.tarr@gmail.com'
  spec.homepage = "http://github.com/dominictarr/#{spec.name}"
  spec.version = '0.0.1'
  spec.summary = 'run sandbox ruby from monkeypatching, by running the code in another ruby process.'
  spec.description = <<-EOF
		monkeybox runs ruby code in another ruby process.
  EOF
  spec.require_path = "./"
  spec.files = Dir['*.rb']  + Dir['README']
end
