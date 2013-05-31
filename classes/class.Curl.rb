##
# Quick wrapper for curl
# @author Philip Blyth
#
class Curl

	def initialize url
		@url = url
	end

	# TODO: add more curl commands to persistently use url,
	#       support for config file, form post, etc...

	##
	# @return [String] response
	def simple
		Curl::simple @url
	end

	# Static
	# ------

	##
	# Simple
	# (with silent, silent fail)
	# @static
	# @return [String] response
	#
	def self.simple url
		IO.popen( "curl -sf #{url}" ).read
	end

end
