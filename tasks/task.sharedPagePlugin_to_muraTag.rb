#!/usr/bin/env ruby -w

require '../lib/modules/module.Clipboard.rb'
include Clipboard

REGEX = /(?:~((?:\w|-)+)(?:\^|"))+?/
MURA_TAG = "[mura]dspObject( object = 'plugin', objectid = '829E6FC4-BA1A-6AD3-0B68F83A7C557C86', params = '%s')[/mura]\n\n"

INTRO = <<INTRO

Welcome to the sharedPlugin-to-muraTag-o-Matic 2000
---------------------------------------------------
Copy/Paste the hidden input.
Paste the result using the 'Paste as Plain Text'
button into the Mura Content

Empty <ENTER> to quit.

INTRO

QUESTION = "\n<input>:"
ANSWER = "\nResult copied to clipboard.\n"

puts INTRO + QUESTION

while !(input = gets.chomp).empty?
	output = ''

	input.scan(REGEX).each do |groups|
		output << MURA_TAG % groups[0]
	end

	copy output.strip

	puts ANSWER + QUESTION
end
