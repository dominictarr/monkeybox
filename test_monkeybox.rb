require 'test/unit'
require 'monkeybox'

class TestMonkeyBox < Test::Unit::TestCase
	def test_simple
		sb = MonkeyBox.new.code "print \"hello\"; true"
		sb.run

		assert_equal "hello", sb.output
	
	end

	def test_returned
		sb = MonkeyBox.new.code("print \"hello\"; true").run
		assert sb.returned
		sb2 = MonkeyBox.new.code("false").run

		assert !sb2.returned
	end

	def test_constant
		sb = MonkeyBox.new.code "class NewConstant; end; nil"
		sb.run
		assert_equal "", sb.output
		assert_equal nil, sb.returned	
		begin
			eval "MonkeyBox::NewConstant"
			raise "expected NameError"
		rescue NameError => n
		end

		begin
			eval "NewConstant"
			raise "expected NameError"
		rescue NameError => n
		end
	
	end

	def test_error
		sb = MonkeyBox.new.code "raise \"an exception\""
		sb.run
		#puts sb.output
		assert_equal "", sb.output
		assert sb.error
		assert_equal "RuntimeError", sb.error[:class] 
		assert /an exception/ =~ sb.error[:message] 
		
	end

end


