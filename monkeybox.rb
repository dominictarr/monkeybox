require 'rubygems'
require 'open4'
require 'quick_attr'
require 'std_capture'
#require 'sandbox'

#what happens if you are running a sandbox, but you give it something with a syntax error?

class MonkeyBox
	extend QuickAttr
	quick_attr :code,:output,:returned,:error

	def wrap monkeys
		%{
			require 'std_capture'
			require 'yaml'
			out = nil
			err = nil
			ret  = nil
			out = StdCapture.capture {
				begin
					ret = eval {#{code}}
				rescue Exception => e
					err = exception
				end
			}
			puts {:output => out,
				:returned => ret,		
				:error => {:class => err.class,
					:message => err.message,
					:backtrace => err.backtrace}
			}				
		}
	end
	def upwrap (output)
		result = YAML::load(output)
	end

	def run
	
	  Open4::popen4("ruby #{__FILE__}") do |pid, stdin, stdout, stderr|

			#puts code
			stdin.puts code
      	stdin.close
      	yaml = stdout.read.strip
      	puts "YAML: <#{yaml}>"
      	report = YAML::load(yaml) || {} #need to catch puts, because the test prints a message if the test fails.
 			output report[:output]
 			returned report[:returned]
 			error report[:error]
			puts "==================================="
			puts error
			puts "==================================="
 			err = stderr.read
			raise(err) if (err != "" )

		#you have to check if there was an error your self. 

		end
		self
	end
end
	if __FILE__ == $0 then
		returned = nil

		error = nil
		output = StdCapture.capture {
		code = $stdin.read
			begin
				returned = eval(code)
			rescue Exception => e
				error = e
			end
		}
		r = {:returned => returned,:output => output}
		r[:error] = {:class => error.class.name, :message => error.message, :backtrace => error.backtrace } if error
		puts r.to_yaml
		puts "end".to_yaml #there is a problem with returning null, stdout seems to drop the last new line, so need something acceptable after.
	end

