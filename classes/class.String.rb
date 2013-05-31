##
# String
# ======
# Extensions to Core.String
#
# @author Philip Blyth
#
class String

	##
	# Colorization
	# ------------
	# (for shell)

	##
	# human-readable codes
	@@colors = %w[black red green yellow blue magenta cyan white]

	##
	# set color
	# default: foreground
	def color (code, isBg = false)
		code = String::to_color_code(code)
		prefix = isBg ? 4 : 3
		"\e[#{prefix}#{code}m#{self}\e[#{prefix}9m"
	end

	##
	# wrapper background color
	def bg_color (code)
		self.color(code, true)
	end

	##
	# wrapper for foreground/background color
	def colors (fg, bg)
		self.color(fg).bg_color(bg)
	end

	##
	# short-hands:
	def white	() self.color 'white' end
	def bold	() "\e[1m#{self}\e[22m" end
	def invert	() "\e[7m#{self}\e[27m" end

	##
	# helper to de-humanize to int
	# @static
	# @return [Integer] color code
	def self.to_color_code (stringOrInt)
		stringOrInt.is_a?(String) ? @@colors.index(stringOrInt) : stringOrInt.to_int
	end

end
