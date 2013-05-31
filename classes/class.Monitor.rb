require 'classes/class.Curl.rb'

##
# Monitor
# =======
# Quick wrapper for curl type grep tests
#
# @author Philip Blyth
#
class Monitor

	def initialize url
		@url = url
		@response = Curl::simple @url
		@results = []
	end

	##
	# Tests
	# -----

	def should_contain what, pattern
		self.test what, pattern, "Should contain"
	end

	def should_not_contain what, pattern
		self.test what, pattern, "Should not contain", false
	end

	##
	# Helpers
	# -------

	def test what, pattern, type = '', should_be = true
		result = self.grep pattern
		color = (result == should_be) ? 'gray' : 'red'
		@results.push(type.rjust(25) + ' ' + (what.ljust(25).bold + pattern.to_s).color(color))
	end

	##
	# @return [Boolean] matched
	#
	def grep pattern
		# avoid RegExp overhead if simple String
		if pattern.is_a? String
			!!@response.index(pattern)
		else
			!!@response.grep(pattern)
		end
	end

	##
	# Output
	#
	def to_s
		output = ''
		@results.each do |result|
			output << result << "\n"
		end
		output
	end

end
